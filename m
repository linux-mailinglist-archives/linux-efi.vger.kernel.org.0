Return-Path: <linux-efi+bounces-5970-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 5430FD080D9
	for <lists+linux-efi@lfdr.de>; Fri, 09 Jan 2026 10:03:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B8C55301834A
	for <lists+linux-efi@lfdr.de>; Fri,  9 Jan 2026 09:02:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40F8A32ED36;
	Fri,  9 Jan 2026 09:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="agkzSWv+";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="fJedFdNd"
X-Original-To: linux-efi@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F7052FE598
	for <linux-efi@vger.kernel.org>; Fri,  9 Jan 2026 09:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767949364; cv=none; b=Y6BvYjQZadeTbP3WeeChE64RCxbfwlLPz8i22UeH04kxBmEXR3eXtWSexMcWG4/hSB85FF7xr0eSQM7uYHUH0/W1pYZdhoZGd2XRSieNr/SZbhxw2ukQxHFD61LU/QjO+1qabNMlwDZx4E7pg+NeCTNqgNG2sRkcFS4IPkoTWjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767949364; c=relaxed/simple;
	bh=qUtIRS+qNGJhjFA+Y3AJFh/1zZDEKWdPV6JngSIVVUY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kbZDqcQ6JZqITlippuF5ieFx4V44tt14Sc60+24Of47xgqSABYIwF+y0uFSLomrad+OQYzxQzs8mkjpU4OfLZ5nT1I1jjYzXOMhWj9xqDQSil+01G+Blv+vjkOq2OeMjaIi/ffmtQqW+qk4zO80Zyp7AbbsiF+fad8l5AsWdiaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=agkzSWv+; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=fJedFdNd; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6098XPp2822841
	for <linux-efi@vger.kernel.org>; Fri, 9 Jan 2026 09:02:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=ZsTYqbukSC2
	gNcKAlH0Q1txs/g5j4eHRax/TlmVURj0=; b=agkzSWv+DE+oAq68amCweJIWpoJ
	/NiyfB3BYLDFKySSNqiCb62EPqctf7XfQlJWtXnBD4MZZtRbcLz6HsWAJcX67ToQ
	2ONq1FWeJRRjPFt2Cdjm9NNd5WmyOmR9d1eX+3NByk2NsAGILA6plcT63buTOdqa
	8aGZHCmqwdk8nW6qv6+25Q81XUGIcPlB3vgxjAl2SU+geCq/9Z3DT4X0+7oE3J6n
	iB42mfEfTAZWCXKCf1OcmtdZlvFW9Otg6BvH3TFa4q2FfoHehv3D8PEcvHLtyR50
	851YLZushoahf4sWd9jeuJz4kL9vfj87xsefXli4zYhqjAp1e66fasEUJyw==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bjx94g39u-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-efi@vger.kernel.org>; Fri, 09 Jan 2026 09:02:37 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-7b90740249dso4750964b3a.0
        for <linux-efi@vger.kernel.org>; Fri, 09 Jan 2026 01:02:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1767949357; x=1768554157; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZsTYqbukSC2gNcKAlH0Q1txs/g5j4eHRax/TlmVURj0=;
        b=fJedFdNd7aDJTWZ8Is4RHZSZxOq884lvCoysrPSbHQr5kX3tNz1Tmv8r0zt2yC/RBj
         rXHZ5hFkS6S89kgTD3QCG4/PIz7lOSAxa4toR+bi5xuyh4KkIyFaPcMy1YJDVHEufX5N
         rOGE2LkTsYVshG3lYtl69gkXg4LmRWiz1wPQPwuJSbo5aXWxVipV9o/1ywrivZmKKaAC
         BmJJgkuWWRhjg7uDoPIOliiFHF6mikwN8bVjL/5PNaGFWCOYFKXS4k5P9XX5BCacGckR
         ZmMNznp4HyTKuj2MYeA5rlSuVezO/KMJbhKDo4hReuHLjMDeUsORgucMSVaqDQchT4Fw
         5e6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767949357; x=1768554157;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZsTYqbukSC2gNcKAlH0Q1txs/g5j4eHRax/TlmVURj0=;
        b=kJXr15uEruJIcul9nI6/TL6Y7apBRNowRxh5/ttbMn7MWtDD4zJ4MjAob9NDc+emFJ
         ZlX4qj7tipGYeDmcgU04yfitfSyPIR3vlRIYcrMSMx6DIUGF2g4qvU50+mz4DB9d5R2p
         wqsCNKd/8ZAOrSAZ1Pd7bpwP3kdNzFK4WRBLStjUrfV1tCIlV+OBdzSsl6Of/eF2WRro
         HwbNwKI8pcfghekyKtXUS1+wmeZu8lt9ciX99nI6sntyFFkVurOzXdauUSipVQtTuhOD
         fk77SIiiO/mGls9hLwJFIOO9pcXTTl2Co+gAN0nPoCJ1/Htrpp+/1Myu04mZLR2P+k6U
         U9gw==
X-Forwarded-Encrypted: i=1; AJvYcCX/7UaHtg1TO0E5NhA3pqPNXkE1MdnuPfkxhh6oicIeujWgJLgqwZh6M2XGvFcNfdge9ABiwyxuWHI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxbIo9fymATshFrImr2Ehd8nrqKc3///kMFyUpS9PUC0BpIQU0K
	BUg8kN0TUDMUaMDDz1keo9uCb1FX4Vz9Ln5T0YijhaaJaa1x7ij7iHAR3ShIkL+bUTHvjmd70Qp
	wPo3qVxuTOY0U0tFw6/WB+AyCTTRx2A3AqVvxkX+Iy8NHW5IXSN2GIwSQ6p0DhMw=
X-Gm-Gg: AY/fxX4mzyzC/R+LgsZprIvrB06KnfFPGsgcu/vZVvPIInC37cvZhZk5w6ea8MArGz9
	6Okze8yUBq9srB7RHJ9QWR5xxFogkdtMUUtMd8A//gtr2PNQsCzSsMMFjZ3550TYY5H+DMaXTMi
	jgtj6IacEgb3jPKhlJIuaazcQ9kH1pPTE99xTaF5e5IDQy16T47rvEnkGytC2Evl5DBz8reOVI6
	XzdL0D4XG1ha7cbHuKT2XFfPxqk8xYsdqPwtbnrzdgYP5k5xMIzcncZFIIHtK/ppjr1HbOT+qeA
	V0t2PHrrJ3vIC39ZFecfJ/eTNzef+A1WGxFP9AnPGOk7Mpzy5erY6wh3HRzjs0wSYJcPXcKVUdF
	FbLnxTGuRB/gbcQhKuZKOzKRaqR+AHkwS6zTHZS4z5J7sJqySxmpf74nW5/RH8z7lLhFYkrYA3J
	3V3DRbeEqyXR06W2wWy15iuCo3/yyLmO93eg==
X-Received: by 2002:a05:6a00:4388:b0:81d:a1b1:7319 with SMTP id d2e1a72fcca58-81da1c0ba5fmr3618454b3a.8.1767949357316;
        Fri, 09 Jan 2026 01:02:37 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEOyqXvuG3s1YsXIvbbegM8dNOFmUKr/zAttl62kuwT5+fBNngo2bTFR2q6zm58OKrXld9U8g==
X-Received: by 2002:a05:6a00:4388:b0:81d:a1b1:7319 with SMTP id d2e1a72fcca58-81da1c0ba5fmr3618430b3a.8.1767949356857;
        Fri, 09 Jan 2026 01:02:36 -0800 (PST)
Received: from hu-himchau-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-819c59e826asm9831562b3a.54.2026.01.09.01.02.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jan 2026 01:02:36 -0800 (PST)
From: Himanshu Chauhan <himanshu.chauhan@oss.qualcomm.com>
To: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-efi@vger.kernel.org,
        acpica-devel@lists.linux.dev, paul.walmsley@sifive.com,
        palmer@dabbelt.com, lenb@kernel.org, james.morse@arm.com,
        tony.luck@intel.com, ardb@kernel.org, conor@kernel.org,
        cleger@rivosinc.com, robert.moore@intel.com, sunilvl@oss.qualcomm.com,
        anup.patel@oss.qualcomm.com
Cc: Himanshu Chauhan <himanshu.chauhan@oss.qualcomm.com>
Subject: [PATCH v3 01/10] riscv: Define ioremap_cache for RISC-V
Date: Fri,  9 Jan 2026 14:32:15 +0530
Message-ID: <20260109090224.3105465-2-himanshu.chauhan@oss.qualcomm.com>
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
X-Authority-Analysis: v=2.4 cv=RN2+3oi+ c=1 sm=1 tr=0 ts=6960c42e cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=JWN5yfGi9shfayy-Z8YA:9 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-GUID: 0L1O4gzU_kN7PGFzsLQEThJTAKJ-T0Rd
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA5MDA2NCBTYWx0ZWRfX22PjCaBMUJ+o
 5pSs/SBYmMVRtBO60KAM433yz6voJXmPeMLNPyFsjVpU3KhY809ZngBsW6BajsSjmPGXHnuV6fb
 Fx+ffJnjyV17gtBvm+rcj0JDCoCKMArQfOUBEZoiQ9dS8TbcvQ6+OXMGUuwQqUTMqbmyZJZhryW
 plCvXWY+IXxnwBDYBxWg7NVObDPj1hjX66U1PKBMFr1HtDMxxdir89WJjtSiYfmoF6scDzPffTq
 7JxkzDsCDyPnQKZn0aafBQRgA3qCYoDgrhHxvR5B0GZ2dZ7dTJekeGxsrVtcnqorga4yhIpEkiq
 J2H2t4cGO2K/tXqyHyMcax/sjlqDCIj+LCY5r0/lYf6bTqZXWcy6l0n0eTb8+aZTsn88+WbW0V0
 NVgRfUb6rsy1Ai6IUo/jnr7nPOOadoT2JZumHIPfY56vmZZ+BMKZG8SLKYW6lF4BTG/jqhIsBjJ
 /l0xECbiooGWwOovapA==
X-Proofpoint-ORIG-GUID: 0L1O4gzU_kN7PGFzsLQEThJTAKJ-T0Rd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-09_02,2026-01-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 spamscore=0 lowpriorityscore=0 priorityscore=1501 phishscore=0
 malwarescore=0 impostorscore=0 adultscore=0 bulkscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2601090064

bert and einj drivers use ioremap_cache for mapping entries
but ioremap_cache is not defined for RISC-V.

Signed-off-by: Himanshu Chauhan <himanshu.chauhan@oss.qualcomm.com>
---
 arch/riscv/include/asm/io.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/riscv/include/asm/io.h b/arch/riscv/include/asm/io.h
index 09bb5f57a9d3..5550b28f38db 100644
--- a/arch/riscv/include/asm/io.h
+++ b/arch/riscv/include/asm/io.h
@@ -142,6 +142,9 @@ __io_writes_outs(outs, u64, q, __io_pbr(), __io_paw())
 #ifdef CONFIG_MMU
 #define arch_memremap_wb(addr, size, flags)	\
 	((__force void *)ioremap_prot((addr), (size), __pgprot(_PAGE_KERNEL)))
+
+#define ioremap_cache(addr, size)					\
+	((__force void *)ioremap_prot((addr), (size), PAGE_KERNEL))
 #endif
 
 #endif /* _ASM_RISCV_IO_H */
-- 
2.43.0


