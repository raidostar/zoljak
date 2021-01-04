<template>
  <div id="seach-bar">
    <div class="search-area">
      <i class="material-icons search"/>
      <input id="search" type="text" name="searchword" placeholder="작품명 작성자명 학교명 연도 검색" />
    </div>
  </div>
</template>
<script type="text/javascript">
  export default {
    name: 'searchbar',
  }
</script>
<style type="text/css" scoped>
  .search-area{
    text-align: center;
  }
  #search {
    width: 760px;
    padding-left: 50px;
    height: 50px;
    border-radius: 4px;
    border: 1px solid;
  }
  .search {
    position: relative;
    left: 35px;
    top: 7px;
  }
</style>