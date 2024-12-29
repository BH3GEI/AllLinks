#!/bin/bash

# 显示彩色输出
GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

echo -e "${BLUE}🚀 开始部署网站...${NC}"

# 构建网站
echo -e "${BLUE}📦 构建网站...${NC}"
npm run deploy

# 检查构建是否成功
if [ $? -ne 0 ]; then
    echo -e "\033[0;31m❌ 构建失败，请检查错误信息${NC}"
    exit 1
fi

# 获取提交信息
echo -e "${BLUE}💭 请输入提交信息 (例如: Update content):${NC}"
read -r commit_message

# 如果用户没有输入，使用默认信息
if [ -z "$commit_message" ]; then
    commit_message="Update website"
fi

# Git 操作
echo -e "${BLUE}📝 提交更改...${NC}"
git add .
git commit -m "$commit_message"

echo -e "${BLUE}🌐 推送到 GitHub...${NC}"
git push

# 检查推送是否成功
if [ $? -eq 0 ]; then
    echo -e "${GREEN}✅ 部署成功！${NC}"
    echo -e "${GREEN}🌍 网站将在几分钟后更新: https://bh3gei.github.io/AllLinks/${NC}"
else
    echo -e "\033[0;31m❌ 推送失败，请检查错误信息${NC}"
    exit 1
fi 