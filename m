Return-Path: <linux-efi+bounces-5979-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id EE0FED0813C
	for <lists+linux-efi@lfdr.de>; Fri, 09 Jan 2026 10:06:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id DD29F3049232
	for <lists+linux-efi@lfdr.de>; Fri,  9 Jan 2026 09:03:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 421FE356A19;
	Fri,  9 Jan 2026 09:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="QYhlGNSa";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="A0lsPJH5"
X-Original-To: linux-efi@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D21C31ED8A
	for <linux-efi@vger.kernel.org>; Fri,  9 Jan 2026 09:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767949402; cv=none; b=nk7UzyKmfoS/i7ShQLw/6b6uT5eVCQnWohy8F/zgTt2kwM+6NBItneoPdxaeAGoBJFIH4O8cw/s2BcGRwDrNzpqyx+6YXkfpVY8MjNxha8fUWQ73jOSkJQOUdQtkyejrLN9TpgOW1rn3a5QG1U4m2zTBT04EQ5SVirI77O+5jrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767949402; c=relaxed/simple;
	bh=z25NS89FtakA2eko6Ure0qKn5EJXXO+h7R/VGAf7s14=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jdkLq0G8l+zJiIuhsuZV3sFLOnhmvABR27wFi5TLNPulvbpXIdgDbUFu+N25sVfrHJRLXAylY5fzVURq3qNkCzGaWyKKfduK478djPvPlhs0r0n5DHhwqVSWUIuHzg82AlZTev6UzmvckeLtAhIPbbVKeCkXOwI3FclPDyHjnGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=QYhlGNSa; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=A0lsPJH5; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6096aMvG2843049
	for <linux-efi@vger.kernel.org>; Fri, 9 Jan 2026 09:03:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=CYIkrEqrqp8
	jD5QuPnx++ARhgF+TQWP9mqsMoFPAsjM=; b=QYhlGNSa1E8AeS+9k6scumC25RY
	Llo1ynUGgo1yhtVX3rnJ0TyHR8yxA7nGZAWdiDYJq9ySB/O3bjp6GXTDmbCxyp1P
	7HdODDWvrF4RN72k3dg2LD5a74XVPB0lEQ4OcBv0zKvS5lV8RFiv0+TcT7bltSb8
	Kr8OZnN+pUFYLvxCUrWaMI6GHBANnzcVZg8ucs1PPDIIkx7PSwDOnNSEw64yPWdM
	YTMmnGJQw5aScR4WZPRtL19BFXOp5nVETix52Jz+qI2yYubXe0lIykqx21wAQivU
	o3+S2vzQMkk12y836vf4OwBL1DqnxTi2ucQOHcel/cD583VC7OqVsV5NtAQ==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bjjt0hvv8-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-efi@vger.kernel.org>; Fri, 09 Jan 2026 09:03:19 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-c551e6fe4b4so596640a12.3
        for <linux-efi@vger.kernel.org>; Fri, 09 Jan 2026 01:03:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1767949398; x=1768554198; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CYIkrEqrqp8jD5QuPnx++ARhgF+TQWP9mqsMoFPAsjM=;
        b=A0lsPJH5+uzERPPj45pQ+v6AmNpSSrjMkNpw2FDYxtZl1L7ZlWq/v8EdTVQR7t2kVJ
         4wn0vIqI9fLCsrtXUIx+PqbqgvWWRIlGY8OFbZaj9E+egUKnoQh6xAdo5jzyebd7M8B9
         agHu2yRX44Q+E/QZdoNBFHU4jvV6kxRtDA8Rj+HG5MlcTJ7IKfgkPpB/m6yd+p89Z1JZ
         2rFS459ijg2F9nIJNxAdtlIBUBPLD5Duw/1ppOPsAvbM9loQ50BAP7frijEiy58eGIYG
         t1sOA/VweVFk5rtDyP+b56GJdrYFM+kxsTIcJeivgYhMX5Vj+o9FTjvOv7gC99HIPnml
         1ngA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767949398; x=1768554198;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=CYIkrEqrqp8jD5QuPnx++ARhgF+TQWP9mqsMoFPAsjM=;
        b=mIy7H1X34VKsVSMPIgG+NBg+zZkdIGYKAB9qyZjp9/wWpT2CBzeQlAZLLsFa1yGuKs
         3/t2xuWdX8eVorgZysEFUQh8xwikveGf1bNl7NB/aOX8pyWLAgZAzbPqKFQyQcIHbgI1
         lJbmRovDv3C1iLZQc7mKjIzZuAAeKGrkybpNenKrlxPlwIxawhZbv+NUVIdcIILeY7G2
         vKh6VMnhLIQpSuUXNNkVdgkTL48r4vNNveeQusC4uq3KqWaubTG5C6lGIcIfirhamgg4
         6LGSWSCDJq2LMPSl9KxhgMStJPxyBy4FuI2S4Lt7diNsfDdgTb+s8fgTSAnPzVQQzGgM
         OQWQ==
X-Forwarded-Encrypted: i=1; AJvYcCVGrHTYPb+nWIK1InvaVxR+2bXU51UxFOXG3lX+QE3FvUf7WxR5F9DkwNAoTPuJ0MEx3WsJaUylJOI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6TKBTehPbN1C3vyhl3OgjQsSMiNx6txzRd9+zx8I8vpBGNk7E
	zaNFD2VflcZNdgL7l+NTO95VOC/du3xgRnTlH2z98NDdUnT/e5fizm4isdiJnMSL78cwS5LJIML
	168a6ecHo/aMexEsbW/60H0njHI4iJ+EXrkqBK+VkWdP80aLafJsKv00xKhoS59k=
X-Gm-Gg: AY/fxX6PL9rgoSGPTpe5KH0IAY1WFAtFzeYW+K0T2MwORCcaR4zlfl4zTFUgirM48TP
	CyA5ofPlLviJpvrOpEeCrO0K5JCv80O6cBTw1Ekw3Gsa4NfQwbu1TXLqUhZLSPn02u1O41ufz5E
	kyQEpgJH/DxDy5JQBVm8hd3F+Wxo9UQEi3b6UyZ6Px4GxNYt1tTV987L+anWS/3Q6kSwbDxZCl8
	EW4LafGHTYA+BeUB7wt3iO6FLMRwAvszl47gqO0bESW/dlyksrR8ieh38x7z21RX18DvezK2t61
	+dOUv1HDzcyhiw9bgLeCub6gtIyE1JPcfLhWDEY8VEE0rdcS5C9h+LrOsKkrMb6tGJPt/wGSAcV
	q5W33will0VI0AEATPIxClgt+d3LMuuyOcm5TaaTwUnZAJYPD0nApDDrL9dN+uCqau31GCyjQDO
	UIcXBG2oD49HoSxI71wO1qQBy9UAHp/iU4sQ==
X-Received: by 2002:a05:6a00:369b:b0:7ab:4106:8508 with SMTP id d2e1a72fcca58-81b7de5ded2mr8194211b3a.28.1767949398518;
        Fri, 09 Jan 2026 01:03:18 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGZwwdauYHJ7mo9yWi9RFBYJfFv9+fHWbIuLHl8/MaWDzNNkxmOHuFcgwapDAslrzzgxq5nlQ==
X-Received: by 2002:a05:6a00:369b:b0:7ab:4106:8508 with SMTP id d2e1a72fcca58-81b7de5ded2mr8194191b3a.28.1767949398002;
        Fri, 09 Jan 2026 01:03:18 -0800 (PST)
Received: from hu-himchau-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-819c59e826asm9831562b3a.54.2026.01.09.01.03.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jan 2026 01:03:17 -0800 (PST)
From: Himanshu Chauhan <himanshu.chauhan@oss.qualcomm.com>
To: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-efi@vger.kernel.org,
        acpica-devel@lists.linux.dev, paul.walmsley@sifive.com,
        palmer@dabbelt.com, lenb@kernel.org, james.morse@arm.com,
        tony.luck@intel.com, ardb@kernel.org, conor@kernel.org,
        cleger@rivosinc.com, robert.moore@intel.com, sunilvl@oss.qualcomm.com,
        anup.patel@oss.qualcomm.com
Cc: Himanshu Chauhan <himanshu.chauhan@oss.qualcomm.com>
Subject: [PATCH v3 10/10] riscv: Enable APEI GHES driver in defconfig
Date: Fri,  9 Jan 2026 14:32:24 +0530
Message-ID: <20260109090224.3105465-11-himanshu.chauhan@oss.qualcomm.com>
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
X-Proofpoint-GUID: aufC014SydiMVs4SwU1XTBmI9IQfXi2w
X-Authority-Analysis: v=2.4 cv=VJzQXtPX c=1 sm=1 tr=0 ts=6960c457 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=xUlk1AThICIXWUt23vsA:9 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-ORIG-GUID: aufC014SydiMVs4SwU1XTBmI9IQfXi2w
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA5MDA2NCBTYWx0ZWRfX8dlkSqfRGhcN
 4pHnr80G2BZPX2Q39I2avwMkw4Iuv1m3hKO9P4MEfNr/p1tn5XMv1HDAlBCUIMMxfyBPmovO9lr
 4GJTkqvXlROAAXyp/ZxE1s94KRt0wadNtCusna5c0p7cmX7Ifa9clp4xrt14JMctYKk+A9ojC0E
 Ftu0QHK+Cbhgtfocjw5uLPTJRDaATOejTYgs8OGkHSLaMPwDK9b/4pTbnmih6DHgW7slr2aH7TT
 Hzci6SMMXRqI9gvB7n1TAx4qSIhRzw4CKxDTbvQU/ye38PsaO0TnhI9pS0AIuVr9xuRKq9iZrDk
 PCRAE8GHLA5FhPCiiiCChK+3fFR7s2XsK370CeyGNZq+Fb88agvFdNBmH/++KP45a0CtsCQ1hgO
 1f5yq7azS6DP1Xaj3E/XIqamRUTG6WMR2U6TA4UxfBK+Ljn8hIP3IfnOwexORRjscK4998+InGL
 cKPMcAn2Gf5ZSeFdqUQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-09_02,2026-01-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 spamscore=0 phishscore=0 clxscore=1015
 priorityscore=1501 adultscore=0 bulkscore=0 lowpriorityscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2512120000
 definitions=main-2601090064

The APEI GHES driver is very important for error handling on ACPI
based platforms so enable it in defconfig.

Signed-off-by: Himanshu Chauhan <himanshu.chauhan@oss.qualcomm.com>
---
 arch/riscv/configs/defconfig | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/riscv/configs/defconfig b/arch/riscv/configs/defconfig
index cd736a1d657e..38b4a802c2d5 100644
--- a/arch/riscv/configs/defconfig
+++ b/arch/riscv/configs/defconfig
@@ -46,6 +46,9 @@ CONFIG_ACPI_CPPC_CPUFREQ=m
 CONFIG_VIRTUALIZATION=y
 CONFIG_KVM=m
 CONFIG_ACPI=y
+CONFIG_ACPI_APEI=y
+CONFIG_ACPI_APEI_GHES=y
+CONFIG_ACPI_APEI_ERST_DEBUG=y
 CONFIG_JUMP_LABEL=y
 CONFIG_MODULES=y
 CONFIG_MODULE_UNLOAD=y
-- 
2.43.0


