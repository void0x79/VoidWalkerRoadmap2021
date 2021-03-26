package main

import (
	"fmt"
	"log"
	"os/exec"
)

func main() {
	install("Terraform")
	install("Minikube")
	install("kubectl")
	prep("minikube", "start")
	prep("terraform", "init")
	prep("terraform", "validate")
	prep("terraform", "plan")

	kube, err := exec.Command("kubectl", "config", "use-context", "minikube").Output()
	if err != nil {
		log.Fatal(err)
	}

	fmt.Println(string(kube))
	fmt.Println("When you are ready, apply your terraform with 'terraform apply' ")
}

func install(program string) {
	programExecPath, err := exec.LookPath(program)

	if err != nil {
		fmt.Println("Error: ", err)
		fmt.Printf("You need to have %s installed and in your $PATH.", program)

	} else {
		fmt.Println("Terraform is located at: ", programExecPath)
	}
}

func prep(primary string, secondary string) {
	fmt.Printf("Running %s ", primary)
	cmd, err := exec.Command(primary, secondary).Output()

	if err != nil {
		log.Fatal(err)
	}
	fmt.Println(string(cmd))
}
