Return-Path: <linux-efi+bounces-5972-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ADE9D080FD
	for <lists+linux-efi@lfdr.de>; Fri, 09 Jan 2026 10:04:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9D3B73016235
	for <lists+linux-efi@lfdr.de>; Fri,  9 Jan 2026 09:03:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CB3B330665;
	Fri,  9 Jan 2026 09:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="VCs9IKIy";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="dfeib3zf"
X-Original-To: linux-efi@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3FB028AAEB
	for <linux-efi@vger.kernel.org>; Fri,  9 Jan 2026 09:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767949373; cv=none; b=lkGnEvJt9CxIjTn3zOaJuArbYKKd5Vrzy9wpIQMdvvg4lUS0BtPFqpkdlcrzLacUkrTz3zgz8O9WIipOhh3Uv1ynw9qqfSZzBchYzGBl+cRLgQNczFZs6cpfYfsk1YzX7FdtsUdrt5jU+1g1QfKBIUua7sBjpM5wJVZItSZsIqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767949373; c=relaxed/simple;
	bh=NJobAjoWQ8xOwxJzStK6E/I8/WwLZImunxfC0L1FZrg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=K6s4j5/WFoQbZ3N0qJ7woismtOSH7NlJnk5sO5G2mpAKfBJhW1CFRHFfNp10s/aIglUEt5Xahk0li8PV06e0mz+uTMc7cHzd8PngnrKXZxDpAaf5avuh8AqSseH5ZxY4MgLu+ZU0EHhW3U9UIZY+uPSmsyShQS38MSDJZFv+Rq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=VCs9IKIy; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=dfeib3zf; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6098EjNP3393674
	for <linux-efi@vger.kernel.org>; Fri, 9 Jan 2026 09:02:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	HvgWc29jzN/49P/rhW+5yK4jRWn0OB7E4Hh0dtdA5Ik=; b=VCs9IKIyu32kpsAI
	ZeiVo0iZDOppFqssC/Ozh8WGL/AqHT1FywG55nAc7ebhALPJp9boD9FebpsEeqnf
	19Z367Nv/06PSRrWvndZvvmp3wPvN8k9Hsjr2p31TTfcpLPtjzxWLgBklXfGJUvI
	JExUbyqIkjniDZLc/1xVF+o51yZfnTJWqlknLYgB/acFJTMY3EfscQUJX8p6kSvQ
	q1kAgD9v0ETtNPNEBuMpybQjS6AQS5vgzmoSThKHC8HkI0VEv/4czhQU7oxIog4H
	DGhA47D3YJ04urCV4QrEmHs8r2gIyZp0cP5Tz3npEl5j7QrtUP2Xf34b/YkDsSEG
	U4sH3g==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bjfejtqfd-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-efi@vger.kernel.org>; Fri, 09 Jan 2026 09:02:47 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-b630753cc38so6607117a12.1
        for <linux-efi@vger.kernel.org>; Fri, 09 Jan 2026 01:02:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1767949366; x=1768554166; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HvgWc29jzN/49P/rhW+5yK4jRWn0OB7E4Hh0dtdA5Ik=;
        b=dfeib3zfU7bb7RHsj4mhyr9nWXyHPsAP1gWmF6rHHIrWiqW6MIs2yKljuCIZ460Ynv
         PSg+NiFHk4ACnYzWwXR9hQSouzZWDmHe42eGFgVxxj4Arrxaaeae2fWJ7LBgvAnekNMJ
         6vdRRCV7Bg0sUSrXbibMS4t+0ZuAvT/Mt0+PAwqCuUuBjJgz6Vy+rxFvKqo5Z8qmruud
         23cVbMDNnNtSiX70Mxjv+foOqLoe7dpxu4n/+ODbdeyh8oc7dIHzYPGeeWvnYHBiZCWn
         zh5azoHBqDBgFJoBTb1wNIzBldl9NP7HwIkdsizTSkgIPHc5Q/FhjdmEugaKyRjKl8DT
         TyiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767949366; x=1768554166;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HvgWc29jzN/49P/rhW+5yK4jRWn0OB7E4Hh0dtdA5Ik=;
        b=JFEazPh8C8mb8X1XFU/U82Ia3ytcFSnEGopxk8ygS749oWwMw2Trp/uuK1E5GJR2R5
         Sh+0gCQ09uhqT+GTZEGJ6vfm1WWMm/+1AV9gc3Wz3ynOEpLEtwFuxkhc3N8qyWhS+sCK
         +D3yV655r5ayilUQAlVsZAh3vZXJcgORKPHl/EiqHY9Tvf2/ZUUJ1TXR1dnwkdf7B9of
         c2GBGXtUTRmAshneCtDdkhXyYXI9OgNxen0JvDLrRztzsjhA3nZ/Zlig7t0w13O+9cqh
         lrILfaDvFacKjjgtFmHL5+9tIK6H3T83XIqO7n9zs63l3VeoyRn3IcqpArK0qVDAZ19T
         pDWw==
X-Forwarded-Encrypted: i=1; AJvYcCWczrolY/XYgLuVTfZv1xJoip9Pi8qkDMdm7LgO0Q66ogPTn+GpqWH3yL5v14E0GGZJi89Sqa7NNHc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxlv8WQtiQYzSaMCJxPGk7vCvF5s78Ho28KIAjEvlmo2zJBEdHU
	I9JnY7wUCgNuIEl5UqocjmoeZlH2riZj9xaXlbuPk6g2/lxx4IIG22NMS18DzhLpC0G8T2D21QV
	GOfTE8X7PW6SSMsyxwbYKSH8fRO40RScqT+G6KSerCSIL6AQFX/Pnj6tX7LintS4=
X-Gm-Gg: AY/fxX4avzcBKE++C4to/YK669Ve6MaWSOTqmuY2quaQOpB9fPbbQUIsgdmDXnsTLhm
	Yrp9M0Menodso3hJp8xjB/JU0MPjNewiKxexOn3sDwhhLOe2ZpIDl3EzzK+0wDuP3NBABXLkKT4
	2zOs6xy9c1JQSgSvVM8/G91RXC011ZIx4k9PJWm2CqwfnR8ziBsAYqp/O+xiG1QTXFMRHRUSdAa
	eIResPzZrUKAgOLw5nNLYUN4/lHHsNIC2/s1CS01w8qZETeIvfMEiaSQoeG4oQkDScb3gj+p/EH
	/iLmvFz7N8t9P8WtTqCOAhQV87h58F4/mCOWnTkHjrVF4xXqaFQm7jV/5nH5IsYa5sNs9ruqToP
	rV5GLA9Pu4h1QBPk6ztrTjOpBPkAPoJyQ3+5KGqwXgHQgfwvfWbIteyKhJMtmv/mXb99xaCnZWU
	elZmEIEwer+BOKODhMv93RnIsxYd+JIryQvg==
X-Received: by 2002:a05:6a00:1d19:b0:7e8:4433:8fa0 with SMTP id d2e1a72fcca58-81b7f8dab26mr8201868b3a.40.1767949366473;
        Fri, 09 Jan 2026 01:02:46 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGKnKdQCBa6kDhoymUf+Gyb4nrZ7PDDZAan9h/ZOlpJJiP8XQhbILGsfxIu865gK5xfMhg2Xg==
X-Received: by 2002:a05:6a00:1d19:b0:7e8:4433:8fa0 with SMTP id d2e1a72fcca58-81b7f8dab26mr8201843b3a.40.1767949366033;
        Fri, 09 Jan 2026 01:02:46 -0800 (PST)
Received: from hu-himchau-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-819c59e826asm9831562b3a.54.2026.01.09.01.02.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jan 2026 01:02:45 -0800 (PST)
From: Himanshu Chauhan <himanshu.chauhan@oss.qualcomm.com>
To: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-efi@vger.kernel.org,
        acpica-devel@lists.linux.dev, paul.walmsley@sifive.com,
        palmer@dabbelt.com, lenb@kernel.org, james.morse@arm.com,
        tony.luck@intel.com, ardb@kernel.org, conor@kernel.org,
        cleger@rivosinc.com, robert.moore@intel.com, sunilvl@oss.qualcomm.com,
        anup.patel@oss.qualcomm.com
Cc: Himanshu Chauhan <himanshu.chauhan@oss.qualcomm.com>
Subject: [PATCH v3 03/10] acpi: Introduce SSE in HEST notification types
Date: Fri,  9 Jan 2026 14:32:17 +0530
Message-ID: <20260109090224.3105465-4-himanshu.chauhan@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260109090224.3105465-1-himanshu.chauhan@oss.qualcomm.com>
References: <20260109090224.3105465-1-himanshu.chauhan@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: 2WVpmgMl_P0IB1PiFaqV_oP1_Y3bco5n
X-Proofpoint-GUID: 2WVpmgMl_P0IB1PiFaqV_oP1_Y3bco5n
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA5MDA2NCBTYWx0ZWRfXxrXkxfGtFiEM
 AET8wx4jV8kikLc9PYdw3LHAdq3um61rg00e7uNLtDDw0kK1r+K7rn1xxeGVQlneIctaQquk0o6
 AEmISg4NxBS9LE3jBTkESF7geGKjD+c9jay1VoVwxkM9UAfRHRY2v3H9shgnlN0oExXhS5PK9pe
 LQrMtaeJ2QTMnCtTIcEulSQIBRbjNHRpzl7H+Ed4u8yRySJIitybxXvtBtf8AYPicpt0jOpbxX9
 oCe5AJjsFS6VkF37B1omDzmz5pAtNonWn/e6QYcOiBfMlQqVENCAASF9xXS4EcMm13WGiDiZFb+
 YoqP9NqXjqoweBq3IfCh59lv25mHYbb56Yb/l3oA67AcG3e9p6nHZKQSu6d1NXI121KuPnJAhiu
 XGMPqGnGyBpBxMtbUtZqS3ONGE/Wy6zUHb9YCjQ66YxDQYsGy/aYluLkT0uu/lJRgOeoFpav0sY
 SMe29JFeXVGqwxWeG+g==
X-Authority-Analysis: v=2.4 cv=ZfAQ98VA c=1 sm=1 tr=0 ts=6960c437 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=h0uksLzaAAAA:8
 a=6zSMeUNXk5_XeOI1LAoA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=_Vgx9l1VpLgwpw_dHYaR:22 a=MSi_79tMYmZZG2gvAgS0:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-09_02,2026-01-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 bulkscore=0 clxscore=1015 lowpriorityscore=0
 adultscore=0 suspectscore=0 impostorscore=0 phishscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2601090064

Introduce a new HEST notification type for RISC-V SSE events.
The GHES entry's notification structure contains the notification
to be used for a given error source. For error sources delivering
events over SSE, it should contain the new SSE notification type.

Signed-off-by: Himanshu Chauhan <himanshu.chauhan@oss.qualcomm.com>
Reviewed-by: Clément Léger <cleger@rivosinc.com>
---
 include/acpi/actbl1.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/acpi/actbl1.h b/include/acpi/actbl1.h
index 7f35eb0e8458..20b490227398 100644
--- a/include/acpi/actbl1.h
+++ b/include/acpi/actbl1.h
@@ -1535,7 +1535,8 @@ enum acpi_hest_notify_types {
 	ACPI_HEST_NOTIFY_SEI = 9,	/* ACPI 6.1 */
 	ACPI_HEST_NOTIFY_GSIV = 10,	/* ACPI 6.1 */
 	ACPI_HEST_NOTIFY_SOFTWARE_DELEGATED = 11,	/* ACPI 6.2 */
-	ACPI_HEST_NOTIFY_RESERVED = 12	/* 12 and greater are reserved */
+	ACPI_HEST_NOTIFY_SSE = 12, /* RISCV SSE */
+	ACPI_HEST_NOTIFY_RESERVED = 13	/* 13 and greater are reserved */
 };
 
 /* Values for config_write_enable bitfield above */
-- 
2.43.0


