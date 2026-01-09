Return-Path: <linux-efi+bounces-5971-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id BD6ABD080E8
	for <lists+linux-efi@lfdr.de>; Fri, 09 Jan 2026 10:03:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 05E053026487
	for <lists+linux-efi@lfdr.de>; Fri,  9 Jan 2026 09:02:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FB2A330665;
	Fri,  9 Jan 2026 09:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="VLYnbIfi";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="kOdJjR3z"
X-Original-To: linux-efi@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E162C8EB
	for <linux-efi@vger.kernel.org>; Fri,  9 Jan 2026 09:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767949367; cv=none; b=TU0cL9FfUhrwyd7M2oWrDmzlstyl2LVCUdhFZo0XK5o9TdIJT9uRW03gMEzPhSaCsvhvGgXaetrrPjpXQM46e9+RvgyxJNollUTOveck1PMd80Buf/RL20DsV2piNOvLimBwZro4NYR+4K0W+JkbpJ+4tqXjojCyT4FgYN13yN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767949367; c=relaxed/simple;
	bh=e6foTb0AMN9HIN6gj2PSEn4vtPlZHgKWuphSixUcW9w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iZST/NQsZ0pAmYxMJNheF8ZpMC2zOm1Eho8drN5sflEYcvvPmH66VGvvfsCGZrVGfVM0n64P9G9lZiukyGGUwM7ZavCarML+3TiJyQ4aIaLOsDasWAAclyriiKLSBwkrNcEAK6cygnjWN8K7waAkWCKC4JiXWcbtg0FXLuvs3eE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=VLYnbIfi; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=kOdJjR3z; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60960ccq3019322
	for <linux-efi@vger.kernel.org>; Fri, 9 Jan 2026 09:02:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=m2SLt+ibhBF
	eKeTazqX12oxB+MUF6EudEtGynVS4dKk=; b=VLYnbIfi+3ZbXTAor5IETt3WWB6
	pieuPY13RqGZL2vjDCN6I3r2xswRglaQbWCepMrq3DT0vLSx0INPxWUHNHxYekOo
	AO6cUKlzhACVZaqMR4K6n9z6y6H5v4oQZG2FkglLrcR3JxaJRKEhjAiKKtsyzfUl
	1Q5gAlKqiHIduWatuQRpDsqyFIrcA7uT+rKs8gQbCd55YtY4q+0EUeta2qDXUO5b
	SAnsUkazdaXPvyhmDHsoO+cVqRIMpL77FfOGb97LBC50kFv1jR+AoUzy98ye77ST
	yzRJyAhd57Y9rXZuQNC26xpFU16wFNmpL3qKYSIDpNzNK/19aXugTegD8Vw==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bjjk3j21w-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-efi@vger.kernel.org>; Fri, 09 Jan 2026 09:02:42 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-81c68fef4d4so3379165b3a.2
        for <linux-efi@vger.kernel.org>; Fri, 09 Jan 2026 01:02:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1767949362; x=1768554162; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m2SLt+ibhBFeKeTazqX12oxB+MUF6EudEtGynVS4dKk=;
        b=kOdJjR3zJ3MHLdezm9wcV+rNuZ1VBGP7VH3TCGX1oUiIlVu0PCftpVRzcfG8QTzfnM
         krziRyztpQA/9Ct6eqCYg24PqtWtIaJGcuk5iupJlqqph75xqj7tF7V4RrLHkIwti7v5
         zrm9n80d3n7pvCyE2kdZA3jBXBvFgLc0iuyxo5tERNnnVOO+8C1EgWGbhlYqgcdXgWDv
         4h8Jq6jA7GHqeP5+jsBtZlFO65MEBmETRMkZotnkH8OxtaVmGDJr4svwKnB2ZbRn7BgJ
         f6WCX86egwK2QDcPBiZqP0cQBJgPxR8yM4GLboDZVSvGYhtszG3VbrX1nWrMAHU6GzEN
         5n1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767949362; x=1768554162;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=m2SLt+ibhBFeKeTazqX12oxB+MUF6EudEtGynVS4dKk=;
        b=OoZDlMRnuogUWmyJ2os8dFDyER72yrAlOBjbalCYL4JYdXoZ9fAZDIyQW5+A1inQII
         x+N7DxTmMqMhFRVnnsF/39vCOXFfbGf6HxqWxfb9KjoGh+B0sGKhay6zVNK29bla5ERq
         X4DEcpTx5YhdKZeha5nn7kvU9JIFTOx376uqJIGd+pHpo7oeS8CVgM0g6q2D6VX6JoFl
         jJ+B35A1cBxwgUstdU9IWBGIH1UQnGIIl0wZKCJhHgCVChsR3JK7roDKGjiYRbEibaTM
         aSlSWtF624i8SosgDvLum2ok/Ti/D5HrgQM9f0ORbJpdhKZ6Vx23zE3IR2d4uEjkmRXX
         16bw==
X-Forwarded-Encrypted: i=1; AJvYcCVA9B0Iy3OGECw6+QqYUeyaMjJtOgioHriwq7W6eZgMBJg+zyYJAp1gtx4HkdNREbIICqkQTU113Gc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+SrlCEuc/DVeYgxV9VKK/LswqiAxEY40RLFlPJrZdKwq7sjMg
	Y+KDYqsSUJ5zjUVSXSiZPD/p4sISPpDZpqdG1nkMKUVi5Q1laDy2ZGjSXxaNPRGEvHU3hf7v5W7
	jtGRYUJtkVqXTTh8GxZ4djJZscDGgy4Uc1FLemEWr37EMkCrkrYu8dTd85qukBIc=
X-Gm-Gg: AY/fxX4m+FDTQnU1DBtv2uevaUB6n98xtOLaJd6V+o4mpOhTF3l1gF2cmK9XkJHhjA2
	OyhGdYEWNrjWMK2xXaUl5t+2Tzf/wiPypi8I8ttbygAk2Myky4Wgn04xvBDCBAzaVfZvdO3ZPxr
	A851XhpYNeV4yYxtUCi0oLsAcc+dLw3JLGmouzFFyl2tnfn2sq5rFgWhtfADKcXhlAbA4ELwJbL
	K6li4vtXASW+1JDqtPoepztQW/BH0xbnLkZ3cCLnTi4s2jWjasNWTFRIy10DYtTktQbDjccXABR
	k7tf1rJ/ahIWkeTMGgF/a1y4i0qC8hSqIcH/OLLtwqAz+fQQB8wojyl6vIjvmEKcTzOse/Ogv4E
	KpaD5Fu5WMgd+dQ/qiXTaKE41hOUUdQiQaL8pSv5B+CmLjzJmDPBM06CBZB+IU0xTDPVJOKvB4m
	aYl1xpFTonXwnBaZ34sfqwPCqUx9PpxwuczQ==
X-Received: by 2002:a05:6a00:299a:b0:817:9a85:549f with SMTP id d2e1a72fcca58-81b7d850288mr9071304b3a.20.1767949361939;
        Fri, 09 Jan 2026 01:02:41 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGIp5ZpFALhNPNu+WcxBmPwkXjHrQyIuUsng8/3QgDICBnsVVjJqmXuPHr0vGK3StfS35fRmA==
X-Received: by 2002:a05:6a00:299a:b0:817:9a85:549f with SMTP id d2e1a72fcca58-81b7d850288mr9071263b3a.20.1767949361442;
        Fri, 09 Jan 2026 01:02:41 -0800 (PST)
Received: from hu-himchau-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-819c59e826asm9831562b3a.54.2026.01.09.01.02.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jan 2026 01:02:40 -0800 (PST)
From: Himanshu Chauhan <himanshu.chauhan@oss.qualcomm.com>
To: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-efi@vger.kernel.org,
        acpica-devel@lists.linux.dev, paul.walmsley@sifive.com,
        palmer@dabbelt.com, lenb@kernel.org, james.morse@arm.com,
        tony.luck@intel.com, ardb@kernel.org, conor@kernel.org,
        cleger@rivosinc.com, robert.moore@intel.com, sunilvl@oss.qualcomm.com,
        anup.patel@oss.qualcomm.com
Cc: Himanshu Chauhan <himanshu.chauhan@oss.qualcomm.com>
Subject: [PATCH v3 02/10] riscv: Define arch_apei_get_mem_attribute for RISC-V
Date: Fri,  9 Jan 2026 14:32:16 +0530
Message-ID: <20260109090224.3105465-3-himanshu.chauhan@oss.qualcomm.com>
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
X-Proofpoint-ORIG-GUID: YyU_QcyXjojlA71d2nUqCRSL2HUQpYeG
X-Authority-Analysis: v=2.4 cv=EazFgfmC c=1 sm=1 tr=0 ts=6960c432 cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=I3DjZvlWSiOXn3_7CcgA:9 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-GUID: YyU_QcyXjojlA71d2nUqCRSL2HUQpYeG
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA5MDA2NCBTYWx0ZWRfX10cmZGQ/n+A7
 dzM3zxRrMDEcRRtUZheRtMJXhMIylH03keB9zfa2ZQaZPlztoJnMBNq4Q/A3+LXFr5aqlDgSOgS
 DgBEABU2/RnisAt7IDefDc5cKTp56ocwVePmCWLVpPURJvCwg4ZpOvWVT7MbIvXN1whXvL5FH67
 lqjdIMYThxVh+kYqgOpXsxLFaYJ+7Iter1zwGqkVB9yUuqG/jSH4E5qyLUCIGK+hmhShhe6pa4D
 q2mwa6ftVwZAvFeJOw0+UgReV5MjpftK+WtolV9bj4zY90TlWGcPg3Y/3jMnK83/xdWDJ2oj0r5
 q+/CTjInBhUSwPyfIoOonZrNeInsPFaQxhm1JCByHGnftTBqfVrvVEv40zK/40tClFgGAYkYLmi
 Tzxw7IBAm5Xg8zXR4+KIhOPMhLJ5CnQRSgEJG39eQd8jgIJIUe44h73/psinrAzlZ0jjfNczIzV
 MOJJEj8dheufnhnQtyQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-09_02,2026-01-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 spamscore=0 adultscore=0 impostorscore=0 priorityscore=1501
 malwarescore=0 bulkscore=0 lowpriorityscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2601090064

ghes_map function uses arch_apei_get_mem_attribute to get the
protection bits for a given physical address. These protection
bits are then used to map the physical address.

Signed-off-by: Himanshu Chauhan <himanshu.chauhan@oss.qualcomm.com>
---
 arch/riscv/include/asm/acpi.h | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/riscv/include/asm/acpi.h b/arch/riscv/include/asm/acpi.h
index 6e13695120bc..0c599452ef48 100644
--- a/arch/riscv/include/asm/acpi.h
+++ b/arch/riscv/include/asm/acpi.h
@@ -27,6 +27,26 @@ extern int acpi_disabled;
 extern int acpi_noirq;
 extern int acpi_pci_disabled;
 
+#ifdef	CONFIG_ACPI_APEI
+/*
+ * acpi_disable_cmcff is used in drivers/acpi/apei/hest.c for disabling
+ * IA-32 Architecture Corrected Machine Check (CMC) Firmware-First mode
+ * with a kernel command line parameter "acpi=nocmcoff". But we don't
+ * have this IA-32 specific feature on ARM64, this definition is only
+ * for compatibility.
+ */
+#define acpi_disable_cmcff 1
+static inline pgprot_t arch_apei_get_mem_attribute(phys_addr_t addr)
+{
+	/*
+	 * Until we have a way to look for EFI memory attributes.
+	 */
+	return PAGE_KERNEL;
+}
+#else /* CONFIG_ACPI_APEI */
+#define acpi_disable_cmcff 0
+#endif /* !CONFIG_ACPI_APEI */
+
 static inline void disable_acpi(void)
 {
 	acpi_disabled = 1;
-- 
2.43.0


