document.addEventListener("DOMContentLoaded", function() {
    const selectBox = document.querySelector(".select-box");
    const selected = document.querySelector(".selected");
    // const options = document.querySelector(".options");
    const optionsItems = document.querySelectorAll(".options li");
    const arrows = document.querySelector(".selected i");
    const option = document.getElementById("option");
    
    // 초기화 버튼
    const resetBtn = document.getElementById("reset");
    
    const listSelect = document.getElementById("list-ct");
    const thisParam = new URLSearchParams(window.location.search);
    const currentListSize = thisParam.get("listSize") || "10";
    listSelect.value = currentListSize;

    // 클릭하면 보이기 or 숨기기
    selected.addEventListener("click", () => {
        selectBox.classList.toggle("active");
        if(selectBox.classList.contains("active")) {
            arrows.classList.replace("ri-arrow-drop-down-line", "ri-arrow-drop-up-line");
        } else {
            arrows.classList.replace("ri-arrow-drop-up-line", "ri-arrow-drop-down-line");
        }
    });

    // 바깥영역을 클릭했을때도 닫히게
    document.addEventListener("click", function(e) {
        if(!selectBox.contains(e.target)) {
            selectBox.classList.remove("active");
            arrows.classList.replace("ri-arrow-drop-down-line", "ri-arrow-drop-up-line");
        } else {
            arrows.classList.replace("ri-arrow-drop-up-line", "ri-arrow-drop-down-line");
        }
    });

    // 옵션 클릭할때 (options가 닫히고 arrow가 원상복구되고 옵션의 텍스트가 selected에 출력)
    optionsItems.forEach(opt => {
        opt.addEventListener("click", function() {
            console.log(this.textContent);
            selected.textContent = this.textContent;
            option.value = this.getAttribute("data-value");

            selectBox.classList.remove("active");
            arrows.classList.replace("ri-arrow-drop-down-line", "ri-arrow-drop-up-line");
        });
    });

    // 초기화 버튼 클릭시 selectBox와 input hidden 값 초기화
    resetBtn.addEventListener("click", function() {
        selected.innerHTML = '-- 검색선택 -- <i class="ri-arrow-drop-down-line">';
        option.value = "";
        selectBox.classList.remove("active");
    });
    

	const select = document.getElementById("list-ct");
	select.addEventListener("change", function(e) {
		const listSize = e.target.value;
		const params = new URLSearchParams(window.location.search);
		
		params.set("pg", 1); // 페이지 초기화
		params.set("listSize", listSize); // 한 페이지에 보여줄 목록 세팅해서 보냄
		window.location.search = params.toString(); // 페이지 URL 새로 고침

	});
});
