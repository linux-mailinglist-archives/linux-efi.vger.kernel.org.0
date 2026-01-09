Return-Path: <linux-efi+bounces-5975-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E650D0812D
	for <lists+linux-efi@lfdr.de>; Fri, 09 Jan 2026 10:05:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C2C4C303FCEE
	for <lists+linux-efi@lfdr.de>; Fri,  9 Jan 2026 09:03:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 760D43314BF;
	Fri,  9 Jan 2026 09:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="BZYzt1Zl";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="j/w6B1xh"
X-Original-To: linux-efi@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23440330324
	for <linux-efi@vger.kernel.org>; Fri,  9 Jan 2026 09:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767949383; cv=none; b=bbUfdxCZ0hB/s1uimenzleXnAFrr83WqmJNtRa5kZtTYQluMSkY5G+C1x/DfB1ZDoSlPvQcEb8gl0OYSLgRKgjqBiNd+xpvbdN8WIbAREfarb0vIj5xTLeZ2Naz+bGgXh8TP/ZIN3OEZuaaiNgUtzOdA6WPEUXJgoIGRTlclJuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767949383; c=relaxed/simple;
	bh=oEof/wOPgbWYhhNlnzJuAEyOdqQayAwN+vF30IVWeww=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hFkehu76Oamq1FUFtnHA0/AgizszNr3m6/HFoBXlzXPPrSZ2+i5JWYtF7OavcYHjs4uTAiXHlThj2nmOvaMv6DI5byR9pxp88WWOByHRWE22R5I7MefXtsYbQcrhQHwa3mX+veG/1rhoc6z/gpUr3rv3vTLuk807P35B9QEdVwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=BZYzt1Zl; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=j/w6B1xh; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6098hG783727542
	for <linux-efi@vger.kernel.org>; Fri, 9 Jan 2026 09:02:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=d4ucWhJ3h8W
	TC/Vx88wr4lDxFFX8PD/AphAsZy//mrg=; b=BZYzt1ZlebyBfYGZ1iZvKCvxRjV
	/XsXeUmeVGCAr7Y/ZQEnwO5sFv30zU5TIBxzC9+AUfTcMKqD6ZVDQ8fGvZyTe8j0
	l9I01Tn84VvmtT6LkpSzRccL8RZ7ufW7619ncKlnP2UUHefYRSfp1D5rgQcaGkSv
	aT86WU/PP+MUzWVx526bRJt4sfdX9iaxjMgcPiazyxNnGyIHEXsRQ5mtHQIvIV06
	YhCwxiCsHsH0zGPQavn4ccYKouL6LMEjN7hg8k1seu/hQNkT4SX9p/RpcF0okiPS
	foUowAjdtVI0ouAkGy1eDwyDZXSBIZ7wjH5+hqFYENhpp+mR26yLsk+h5Cw==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bjpmkhcvu-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-efi@vger.kernel.org>; Fri, 09 Jan 2026 09:02:56 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-7b9c91b814cso8159166b3a.2
        for <linux-efi@vger.kernel.org>; Fri, 09 Jan 2026 01:02:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1767949376; x=1768554176; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d4ucWhJ3h8WTC/Vx88wr4lDxFFX8PD/AphAsZy//mrg=;
        b=j/w6B1xhcSqUDfh4iYWHqiHbxmRAm5cfLvCydPAgMiDPfKQFcOBRcyLgrsSMUXMOM0
         8L4pFA34iGhJdkBFdHEUZsjtzLFtsdBoRtd5lMeVoe+CkT2B59cCbF+S9I26xec9jpu7
         pvZwyqYpjhvoCTi01qCSEsirhi75IP9kXOzCVkS1s/QFRxNVCcfcdH8Isd9+BIE4308I
         P6S8izBSc1o9GdBMzO4Pu2UCAcovfUa5ejKxMmAFrnVYriz4uS4cPC+LIWjgLdROovnT
         i2gbF/L8Jy6ScrN0igWJpF+v5KnoY8PWoZa0AyDLNFWKmlzYIe77skh8m/mclMmQ0zqP
         U0qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767949376; x=1768554176;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=d4ucWhJ3h8WTC/Vx88wr4lDxFFX8PD/AphAsZy//mrg=;
        b=oclB1KITR3V1vwwbodWOFrVitwDXf8Fb5/wu1WHcFozLYz17uiK6FKHizCrsCk2+oy
         /BIpTDGw4nKMTCErBzQM5APLZha0gPquulz4o4EM/9qyoSJH+M0wIfUCY7HDERjlOIg3
         EU3Ix+2wKIED2+RPYBZKmB2pASWMNUMlkcyPj6dW+h7aHIPVW6MMUlbOSOE8104Mx8Fm
         9Udz1+Lv3XtVsR7d7OYLuuc8uYVf8SdjprmgzMulZQMbmjY0OcPLLzKtM/KPSoYWDcg7
         81t6OpEDPkpiVQvuXB3ZzkA7lK7dR9kj6ZpBsCnyca40wPXPRMZT5UPh/KcYWkocv2ad
         NfKw==
X-Forwarded-Encrypted: i=1; AJvYcCVD1JvarhfrypjnpPKMNt90Td7uCAnkqkY0zs8nblXoIGXfdAkPj+WqW+XvC0x+x4AH6nc9XpJXhBU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyivVBJiWl4ZSDXC1HJ8SyuY+lJerj+pb9hffXu3AfDJX4Ohqxb
	s3RpZ7pFzFDp47msVPuVL5JsadfVv7X6mVmmFYJxSua0hnnVylb3zW9tKxOkhLsag8oInBFJVpV
	cVoYg3GJ6NLSIv1mFA7rQA5fUG9FfykRof5azgb2rVDFWemQ8l5xUl0/9c/6Oafg=
X-Gm-Gg: AY/fxX6uwPdFri3Ie17t+IYNUCQah93F1s5V8YjBFjwgN1N+n0o9vCdrBVXL56THfsy
	+XKIsgx8rlv+jXXVJlGpupNamODIK1ElOZbw8YsmkR7fZMmWfV9ykyk1+KmQSOO2B2pF5q/Quko
	sD0IcsEMjdVuhO/eBwogxcvJUQ/7RLzH57Xj6dSjSNe6eU7XG2mmMxxAlPmxHEnF6o1qdrFa0NG
	D6P9gmQ8IB6XhAWTnSqq0CPtqPrsKRpu6ZFlEPs6kiOmCRSvVQYzO+yao70Yp4c6jsZVl4/7LHU
	lfVD90/ZtTPae89xAoa0TePomN8A3fR2RNHkprikRBQ+AQu6jLQjXS3Ex6X7DmpPGu3T8yTQNzA
	G8J5SXEP10xA28pA8paRwJQqEOVN8Q8/NHo/KAKWmektuwaFWq5tRDdb8lXMG1YWZB5tni3iXbZ
	2Hjd7ZZGxOeiEopxmpG+z7+cdAdwjyypF7qA==
X-Received: by 2002:a05:6a00:909d:b0:7f7:4dc8:55e with SMTP id d2e1a72fcca58-81b7d8621dfmr8786992b3a.7.1767949375635;
        Fri, 09 Jan 2026 01:02:55 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH7zW5d+nSu+0wcfE2eze2NWNEmecsW0E5hntD0qHwPd/5r9VK82uccFBhoCMXa8NAbj/Emew==
X-Received: by 2002:a05:6a00:909d:b0:7f7:4dc8:55e with SMTP id d2e1a72fcca58-81b7d8621dfmr8786945b3a.7.1767949375086;
        Fri, 09 Jan 2026 01:02:55 -0800 (PST)
Received: from hu-himchau-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-819c59e826asm9831562b3a.54.2026.01.09.01.02.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jan 2026 01:02:54 -0800 (PST)
From: Himanshu Chauhan <himanshu.chauhan@oss.qualcomm.com>
To: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-efi@vger.kernel.org,
        acpica-devel@lists.linux.dev, paul.walmsley@sifive.com,
        palmer@dabbelt.com, lenb@kernel.org, james.morse@arm.com,
        tony.luck@intel.com, ardb@kernel.org, conor@kernel.org,
        cleger@rivosinc.com, robert.moore@intel.com, sunilvl@oss.qualcomm.com,
        anup.patel@oss.qualcomm.com
Cc: Himanshu Chauhan <himanshu.chauhan@oss.qualcomm.com>
Subject: [PATCH v3 05/10] riscv: conditionally compile GHES NMI spool function
Date: Fri,  9 Jan 2026 14:32:19 +0530
Message-ID: <20260109090224.3105465-6-himanshu.chauhan@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260109090224.3105465-1-himanshu.chauhan@oss.qualcomm.com>
References: <20260109090224.3105465-1-himanshu.chauhan@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=YNiSCBGx c=1 sm=1 tr=0 ts=6960c440 cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=-FlRX8pefk0TmyAjS3oA:9 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-GUID: U-idnX-H7Amt1dhl5jZZjen390Rrk0re
X-Proofpoint-ORIG-GUID: U-idnX-H7Amt1dhl5jZZjen390Rrk0re
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA5MDA2NCBTYWx0ZWRfX0EO/EJfxL/1G
 YPG8vIUgi/kxdGWWZ0yBHVyvx3u0JH+6/fr4KuRSdOSZi3DvQSlxGMk5UyJSAlnFW9pGeUGh+19
 rKAvQ5IFzWuaVDj3qnz/5EWnppEr8/wwqDWTnskqJilnWWYXYT6Dozdfozk0KNnuHeZ/Pl/8mMS
 8WVy39N+dWWP6oXvtNFv+xdnGFhifG1cZi9rlZMNfGtqO60oWYJUa2X1Z96SKkfhJEurfZmPPCT
 LhvEbHQHaFaxiZ5dO2AaBQ7xf3uRVJgTqHOzuERAX6TpVRGUjlQWfH3EdLtgBgRCPi2tQ7ggVqe
 tcWCViX3do+CL/oeMDKwoCEQIYaQmbgTraKlltiEhmlzjjzLi9qXCXUkVyc9ADJ1UsCN8bdLNjb
 vRvo17K6i8AeSUcIHfwRUzt3QzjzjeiCm5xDtGx5++iiiAfOkonBn8XO51hoVN/Hzm58zJ87k2K
 9uz4HmRd7HmHI+J5Y4Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-09_02,2026-01-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 suspectscore=0 impostorscore=0 adultscore=0
 spamscore=0 lowpriorityscore=0 malwarescore=0 bulkscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2601090064

Compile ghes_in_nmi_spool_from_list only when NMI and SEA
is enabled. Otherwise compilation fails with "defined but
not used" error.

Signed-off-by: Himanshu Chauhan <himanshu.chauhan@oss.qualcomm.com>
---
 drivers/acpi/apei/ghes.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
index 0dc767392a6c..6fd84a1772c6 100644
--- a/drivers/acpi/apei/ghes.c
+++ b/drivers/acpi/apei/ghes.c
@@ -1387,6 +1387,7 @@ static int ghes_in_nmi_queue_one_entry(struct ghes *ghes,
 	return rc;
 }
 
+#if defined(CONFIG_HAVE_ACPI_APEI_NMI) || defined(CONFIG_ACPI_APEI_SEA)
 static int ghes_in_nmi_spool_from_list(struct list_head *rcu_list,
 				       enum fixed_addresses fixmap_idx)
 {
@@ -1405,6 +1406,7 @@ static int ghes_in_nmi_spool_from_list(struct list_head *rcu_list,
 
 	return ret;
 }
+#endif
 
 #ifdef CONFIG_ACPI_APEI_SEA
 static LIST_HEAD(ghes_sea);
-- 
2.43.0


