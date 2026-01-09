Return-Path: <linux-efi+bounces-5978-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C571D08130
	for <lists+linux-efi@lfdr.de>; Fri, 09 Jan 2026 10:05:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 44C6B301AB03
	for <lists+linux-efi@lfdr.de>; Fri,  9 Jan 2026 09:03:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 399C32C0F8E;
	Fri,  9 Jan 2026 09:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ntRZbJyg";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Ktxd0w9b"
X-Original-To: linux-efi@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F9CD331235
	for <linux-efi@vger.kernel.org>; Fri,  9 Jan 2026 09:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767949398; cv=none; b=jnltVAOAoa4m49PdD25A6TvjQN3Yiv2D/GOp2H393tdansH91mpFrTYInB3JlkjRxzRW7JSxzWIRf5Opa6mLyeGMe6H8DVZwrYkhetbdF6EuOV2BiJ7CG/s/vaJlZcBzTzj5ZCWpwkIz0aRdlAgh847eqruf5U21nONByzPtALA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767949398; c=relaxed/simple;
	bh=5AbkwUe4KSHUvslJtTs9okt35cK2ziGtjk7b0QstlZo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XPSJ9fmKZV7jL5OF9miPVEhVJdxlbEDXO1iE8y7S2VmxuAca7mzGfA3UDRfKP2zErXfZebSccD5L0+CmeCi8zVoE40R/MCc/YDft7z7Qmgo+YJSmvLIDgVHOQ7iyN22cOoAFJW6Kya927NIAOHbByrfw99KU7a5iXNnQLCzvFVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ntRZbJyg; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Ktxd0w9b; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6091qSHk3324803
	for <linux-efi@vger.kernel.org>; Fri, 9 Jan 2026 09:03:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=V1pVonEOJuX
	JcP7BoStX++5XFX/aG8G2NnylegJ0870=; b=ntRZbJyg+8my8ljnN0AGP/4c3n3
	nCAtVLnBl9pTa3b2lggy65Q7ADypQisdrHZExjNrjnO5Z5uMomhdJzwelhbMxUmt
	lhl+3bPl1KFvyJ+v//7x6a6vnjHfY7/OzVAECTsPKpwZjq+SOYyaIPPPIa2XG52N
	e12ksXNY5bubRJEnCadm1c8u6UMd8DiRXP4zIj6Xh7jLywh+NKoMDJ93Ts3y4hEs
	P6swjzvLc4gk01QCiB3cLhAJWkJIH5oQcPEb6KWiC8yfCBScy30F0u62mMsVWzq4
	0sDADrmHWOUncbNf7NFqD3ZfvLDoW04Q+JF1x6p7y0pqUDjXi+NQTa2NEeA==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bjrd6h4w5-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-efi@vger.kernel.org>; Fri, 09 Jan 2026 09:03:14 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-7b4933bc4aeso3853367b3a.2
        for <linux-efi@vger.kernel.org>; Fri, 09 Jan 2026 01:03:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1767949394; x=1768554194; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V1pVonEOJuXJcP7BoStX++5XFX/aG8G2NnylegJ0870=;
        b=Ktxd0w9b3nJ0NDGC8tYY2d6F41fKT3wxZAM1T4GnFyIbw3qLQNukhuZruQ0VDBhHGe
         i6eY4Z4SMqgBzGEoDu73D/43UgpGWa+NHokjAQvlW7tnNoMQneiW8D8xEtJku/1myZBo
         D9iuYFgGIeBfHnlIUIInl407sbUuTd9jN6tgMxZMr451SMfzgPwc7kdCUKON/+U2FkdH
         jbcDdm3eQdR3QvpqnrIfWyWzcuNgfkwwE/C+cO5s2Zmm2/uum+Y0svJpbtZU9t4X03Xp
         lv0CrbjTvB6Z622JVUOn/um8sW1pxVA1nBvOxDHfUW/PjlXMbohaRArJ6qEND0ezUzT4
         BHaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767949394; x=1768554194;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=V1pVonEOJuXJcP7BoStX++5XFX/aG8G2NnylegJ0870=;
        b=UsmC01Vt4diVxaiVeK8D+qHWnil1vYSWeAOdp+q3O2sq65nugS4T69kDgIWqGjZd2t
         7HS8KAf6mV2gevKHXJertypijnKj5lT4Z97nuSgUwgiZaLyM1S95JxNOMksFuhtM2m3p
         HrsBWVLzCalEl69+UOLZcGN5o61ogHcfzUM+Ekn/xukrukWVeXN+d0tbovfcIvFmjM3s
         Df8fcDM+UW/wgiuEFv4K/JlAfC1eFr6R47GGpSTWh8uQ2ZRYjwf5cnIdgXkopKxLYMIX
         F26oZQB53mCL/yR3FMnEIuvSm8mJjfN38h1dKtcf2I7q6mjlW3r/O1GaXgF+ZgA/V5X0
         O8Tw==
X-Forwarded-Encrypted: i=1; AJvYcCUe4tBRsnPaqZyGwZ6QtPusMsyJhnDtePwPNHgFfUQ41X59fOvG+EdpRe/32aOnoC8wT/rogxnNCIY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzF5JYlqW6PVXZRVLKKTxSV8aDu+EWtdE3Oq/3QriqlPA/WuuU5
	RQRobEa9VNKw84p8H4G1gOnNM+i4kVvGwumcMJmCDTqvhbwhphs6shR9uZHTWvbvNKP6l9rUBRR
	IxrDo7Zp03cXq6UuNBnLxLjYZA0xPIoumnd/Yvi4izYDJzuF/Ydb35JjaJR8Z4t8=
X-Gm-Gg: AY/fxX5E2KvMKRxpRG0u1ocSosCLFqZOQS5BPhHZr9rwy3DJ1kG85s8fHbiudNSawuH
	GAe9s5TDl+FpKe7wy0xMrGlNCtbshOLvZBgCRcAlcwnbIi6IAGWPeficNKbfwiVsbwlnXUq2Tt4
	qCWHCcZWkqsVQMIVGCnmw9Ny1aAlvBTkaVHfntERJx1m52H75MDivGFjIL1ljQlOWQEfXiK/BlE
	rD0QJkCDaCBWWeWz2H2BxDi+oga2dkGXpSaYp7iO7EDbc5h+l3AhDP0/8pt0nQKlkAvTu2RHBXx
	9xwW9nTFWTOVY2IsG85Zop48TfPuTlLpJYjpUFq1Oo7p7rYD52EmzsX8aV+V57HN85+xQR0GlN5
	u7bQD2+5EIlAwBirs+wOmLLaSNbHvu4QVgKkMttFwZGi7ndIJchKDjywShvdkb7KXmXVrYfoZiW
	3IVYSNbdSEkwUzvm1YzC+u47iXKEb09Zmszw==
X-Received: by 2002:a05:6a00:4394:b0:7ff:e71d:49a4 with SMTP id d2e1a72fcca58-81b7d85305cmr7454261b3a.11.1767949393904;
        Fri, 09 Jan 2026 01:03:13 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGu6Dzzr3vQDc5S1B/XHUHzgN4IyrQ0Y+ZBxjQJDn6l/lNEm6JmdGsaCaXI4BvbmrSGPo9+sQ==
X-Received: by 2002:a05:6a00:4394:b0:7ff:e71d:49a4 with SMTP id d2e1a72fcca58-81b7d85305cmr7454225b3a.11.1767949393427;
        Fri, 09 Jan 2026 01:03:13 -0800 (PST)
Received: from hu-himchau-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-819c59e826asm9831562b3a.54.2026.01.09.01.03.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jan 2026 01:03:13 -0800 (PST)
From: Himanshu Chauhan <himanshu.chauhan@oss.qualcomm.com>
To: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-efi@vger.kernel.org,
        acpica-devel@lists.linux.dev, paul.walmsley@sifive.com,
        palmer@dabbelt.com, lenb@kernel.org, james.morse@arm.com,
        tony.luck@intel.com, ardb@kernel.org, conor@kernel.org,
        cleger@rivosinc.com, robert.moore@intel.com, sunilvl@oss.qualcomm.com,
        anup.patel@oss.qualcomm.com
Cc: Himanshu Chauhan <himanshu.chauhan@oss.qualcomm.com>
Subject: [PATCH v3 09/10] riscv: Select HAVE_ACPI_APEI required for RAS
Date: Fri,  9 Jan 2026 14:32:23 +0530
Message-ID: <20260109090224.3105465-10-himanshu.chauhan@oss.qualcomm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA5MDA2NCBTYWx0ZWRfXwqnFgzE08f9b
 yYdsn8u10RfIoAfeNUi00y9r/HYxBVsIZxPNhx6vMVeK7odhYcpegsmRTWmyFYimncxsOhv7uot
 FEDbGKUO81NYFaV/cOWQOOtJ/EDT57tIXoJZ/Phl5yMbUomxmLDXuSe/qpUQEgwevovyGsnVNZt
 friKjWwSumT+ijdZoDO03yV6f2zElpoVIJnNEuWl9t/6iO34X3Q5mdrOWUlRjLeoy8mUypXkmSm
 ejLMV/mJnCXfR0gWFjbKwBYMlePyD1vylKKcvicyIiXhokFnb7x+mhquBxf5usptUk1L4s16/uM
 ivOzyJ+w4v8pSa5LjrrNirVvCpFGRfq9K9sTkY33qlXu/04k8VEZ7Z6PS1Y/BGP64kgAOwkVfdx
 Gp1TVz6BH+Js9z3Mf6V6yaspcajYKctKS+UApax/qNHxvlW/2GEcscsY711SesHaGvq8aZnmv/+
 px4F1Nd/XMrrpYp6RdA==
X-Proofpoint-GUID: QXKqUGdfdQaOgK5uSjlzsBW6fLqv06KB
X-Proofpoint-ORIG-GUID: QXKqUGdfdQaOgK5uSjlzsBW6fLqv06KB
X-Authority-Analysis: v=2.4 cv=Xtf3+FF9 c=1 sm=1 tr=0 ts=6960c452 cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=B44PnEIMzw-PxGPnmokA:9 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-09_02,2026-01-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 lowpriorityscore=0 impostorscore=0
 malwarescore=0 adultscore=0 clxscore=1015 suspectscore=0 spamscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2512120000
 definitions=main-2601090064

Select the HAVE_ACPI_APEI option so that APEI GHES config options
are visible.

Signed-off-by: Himanshu Chauhan <himanshu.chauhan@oss.qualcomm.com>
---
 arch/riscv/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 6b39f37f769a..ef3f052e97c5 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -187,6 +187,7 @@ config RISCV
 	select HAVE_MOVE_PUD
 	select HAVE_PAGE_SIZE_4KB
 	select HAVE_PCI
+	select HAVE_ACPI_APEI if ACPI
 	select HAVE_PERF_EVENTS
 	select HAVE_PERF_REGS
 	select HAVE_PERF_USER_STACK_DUMP
-- 
2.43.0


