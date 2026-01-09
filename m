Return-Path: <linux-efi+bounces-5976-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 49AF8D0811C
	for <lists+linux-efi@lfdr.de>; Fri, 09 Jan 2026 10:05:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 58ECD303E0D9
	for <lists+linux-efi@lfdr.de>; Fri,  9 Jan 2026 09:03:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2DEB356A08;
	Fri,  9 Jan 2026 09:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="j9naqlU7";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Vff9fl3K"
X-Original-To: linux-efi@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA961331234
	for <linux-efi@vger.kernel.org>; Fri,  9 Jan 2026 09:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767949388; cv=none; b=D10mbIzk3plJ6em5NYZ50EzJByeChzlV3xS8orCX/NfglfsSqmcbjQdpP1FEYSipnU2upWGOKKUbkKj6CnZLEGVpAXKlGSEmm/StOK7H4WHawqMeybuoxx6u6UO0J1omJ27yOobpRootZANI7bMuUD8dnuMQhX1a2QuNJZS53CQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767949388; c=relaxed/simple;
	bh=EP/YRbXVni6KnkHqzoLkfNZUBJCRLmzZeoDK8CqJDaw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GZHXuOEU4bYLxlXopBhTvtXxsEpvFLIbyhIF1s5e0RjLxGRbEi/twT6n7w6oZVyBJ+BY8RvDylR5HsRvyhAacxXirvv7cG1KUmRmr4r2uA9Ejxh4gAhTW1fAamFb8x8UE745QsRke/X6OXVQtckdvR+BIljmP5hD/5mnJVxbKnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=j9naqlU7; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Vff9fl3K; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60987mb83625832
	for <linux-efi@vger.kernel.org>; Fri, 9 Jan 2026 09:03:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=asLWQeaR4rF
	QlIKMK2s38SWm7Eqp5rcJ/qvyglZlI+Y=; b=j9naqlU7FvOy/xPALLlXbSgEqH3
	n9vTSdmk2dj0lEWOCOz8hG7TiXaBDugBCyDyE6a8HXeuIOAi2OYqXvwrrOn7MUJh
	07XALIKMgcCv86VYtLSvU+wEzidral4Ejc0vPTx6pq+S/lBvYAHIazkLHKuWyBro
	DEX3HhPVk49ZnIheyBZaTwBIfX6+coq60a7g+KvTmtxpPCuNVaF0Nk9FP5sbaSi4
	bNt9wmwYL9KZatmrw/TeBEicrfN1+b8ZpwZx3nRw/AUneHycuZ0JrQF6rKCqIDs5
	4FNf+Q9mlTC0VsNJeCveoWhxw91bIlNYZZTkXpKUeFTJPgaZfi9UydAuV0A==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bjj8j21c0-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-efi@vger.kernel.org>; Fri, 09 Jan 2026 09:03:05 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-7d481452732so4788134b3a.1
        for <linux-efi@vger.kernel.org>; Fri, 09 Jan 2026 01:03:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1767949385; x=1768554185; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=asLWQeaR4rFQlIKMK2s38SWm7Eqp5rcJ/qvyglZlI+Y=;
        b=Vff9fl3KsrV2qGT+3l86zGQ9NQVFE+CW0OeNC/nd3zBUNH7aw/4vjYBwO2JACWe8vq
         y6i9OmM1NWaAl36AaOymJoAxJxwEDyUTH/yRNCGqzg2xvGEy5r0M1pcOKBCgklYNwDEt
         ryZ9SVARYEr4XD1m7NooEqfOU5DauS5eXLHfNV77T+uZ3WSHjtmfJNREfrO31qxloO4X
         5KnNy5Bqb6ifRipwNKy8ytw04NhGNGvfl+qlE7J/mofNLQipJvhfjROUxGFIvPe0nQKb
         9fw0Dg5NwqX21QSADeWOb0b/5BMNXN3jC9/PEHi7V/bqjMtber0xy02jxdU1u9YHEdxi
         MKFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767949385; x=1768554185;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=asLWQeaR4rFQlIKMK2s38SWm7Eqp5rcJ/qvyglZlI+Y=;
        b=Ay1y+RuBzO0fzFdIxC9/9p2uNctqNUIAKI8vI2ecMN53zFsa3XossDj/+50oOp4+Ye
         IULv79WknLazUfiY/SsgXkTb7WXURFyFyqHJRGDVnsH0VnR34wGij11CZFfkvLng3kGz
         V09zbURL46mX3UrJ2mFkcpgAjJLb3VN+O0mdb12rnDeIhkEef3jt5KnXEfQJCh2OR0tG
         w1mpzeYzSb7g/9fDo3jM3jOUI9xsRzWiLHzFE1J9t/g7583dNR1+Ard0YPXQ4TskNzhI
         Q/NeJ2cdZ9Cju7vUHmIqXMoQmI5P3hoZXj7aZwL9oJCq9j0JHjctUHvcyGDo6oCO+nMz
         VhBA==
X-Forwarded-Encrypted: i=1; AJvYcCWwKpOfioKj2vig2IWWIXT44tD9dsBrPSI1E8bX5AIrq2Rsod+BJMuxIQo8JbCRPcSh2w1HBjYyKN8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGGE7M6xtTCkQSpAvdd+Uau4zkAynFl7rBb5XKOw5j86Ovr/Kc
	F4G9guU6yjIhMyjW+PmD5tmdtvO2enIhxJzkQ2oC4GF/vH594pmpaJLGMQP/dKrVbyjoEIhfq/5
	ix82ynFyi/0t2DvOZWGLsEXRWA340e5QEIL25AQ5V1NCma7G833l4SR93a2sueEQ=
X-Gm-Gg: AY/fxX6G/gq9jSrsP/6WQv5N8M6/OuBco98l9FnYVsXIpoD4Ym7yDrredE2fFoYpSON
	gmW4v+Czr1udGtlJ/EoPXuMJ2OEP8dm1xOK8GFQBUcRE7GAUC+IZuMI2RziDU9EVRktqvUVeTJ9
	2BeUlm5i97CbdSzL1wgqgcYZSmLAQ9tIeCrA7B/bgRQOm7cpbcYTKTXDAhZ9rWwbefVfqSSHfI7
	UwhqJo1IpM0j9G3OLrYWOrocVyuwsiVC8103AhqJjiD6lVlS57ucbD8Pd6KweJ7abLh7eN43Kep
	dLU8RcqGYb/bJdij3fhQb+QZWh8YKgCEZDq/Xu4vEMAkBNIfr1WErqO+2TS/iud1deQD5XP9xkW
	eA7QTqYP8r1UJioj/kvraa4iNmSgYxpwg/e1cFfXZVwlI/5dDkOnf6hT5w0ZN59uLUYEB2JItjQ
	0Uw+QzrPQuwYvSakNWvwMv5V0UFAA+kIzw2A==
X-Received: by 2002:aa7:808a:0:b0:81e:96c9:1335 with SMTP id d2e1a72fcca58-81e96c9166amr509863b3a.21.1767949384612;
        Fri, 09 Jan 2026 01:03:04 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEQwj/yWlof0KqeGRkT5R3hBYh980k6Id0SZ+6+0ezp1wE4OVTwE/4kvoozGGXmSkIj0VWIKw==
X-Received: by 2002:aa7:808a:0:b0:81e:96c9:1335 with SMTP id d2e1a72fcca58-81e96c9166amr509835b3a.21.1767949384107;
        Fri, 09 Jan 2026 01:03:04 -0800 (PST)
Received: from hu-himchau-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-819c59e826asm9831562b3a.54.2026.01.09.01.02.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jan 2026 01:03:03 -0800 (PST)
From: Himanshu Chauhan <himanshu.chauhan@oss.qualcomm.com>
To: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-efi@vger.kernel.org,
        acpica-devel@lists.linux.dev, paul.walmsley@sifive.com,
        palmer@dabbelt.com, lenb@kernel.org, james.morse@arm.com,
        tony.luck@intel.com, ardb@kernel.org, conor@kernel.org,
        cleger@rivosinc.com, robert.moore@intel.com, sunilvl@oss.qualcomm.com,
        anup.patel@oss.qualcomm.com
Cc: Himanshu Chauhan <himanshu.chauhan@oss.qualcomm.com>
Subject: [PATCH v3 07/10] riscv: Add RISC-V entries in processor type and ISA strings
Date: Fri,  9 Jan 2026 14:32:21 +0530
Message-ID: <20260109090224.3105465-8-himanshu.chauhan@oss.qualcomm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA5MDA2NCBTYWx0ZWRfX8Q33vwETTT4n
 o97QGd7rEccg0cIY4SGyBJN0pwiQumIt5QKhFOJJKbkEji2paK0S7Hp8M9OH7ZJNL375kMaG8oO
 m/qOVNn5al5dLllcZkPe+wvwOqp1ZuiKQFDTMTmxaoTDsaMs2AlTDYS2G74fdGr+xOnmDoz/IYX
 WR89Y9ZdHxMXeApEs4VIYm75cw3t8TgkG+mgofeeIyXj3+p6Ykfh76RH/lNhSdIbghJd8tnx1GW
 /T6dRCzLjoRGb9Y4Q7YYsUp21t8N+5GSrWic9cbn96au+4SwHcvBnETkH/lgkxMk//awI8S1FCc
 ShOitglkE9OecEzasFbPNCM+8aXDzEaic9CdsvPpKGGus2QwnwId90V3g3nWFXKR7NVqLxHaJVu
 LVuilrIZe6hyy4S2XFamkfXL6JUs1wFIsdQPwu9QMHew2mbN4NyD7z/X/lT2T2bLXg/QpiDWNZQ
 TFv+GygO3J+boMUO0ng==
X-Authority-Analysis: v=2.4 cv=JIs2csKb c=1 sm=1 tr=0 ts=6960c449 cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=aZI88Kzba1cNDf5AQqoA:9 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-GUID: gCVOVBBiJu91r9s_rbDBbiY6SclvisQ9
X-Proofpoint-ORIG-GUID: gCVOVBBiJu91r9s_rbDBbiY6SclvisQ9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-09_02,2026-01-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 priorityscore=1501 lowpriorityscore=0
 impostorscore=0 bulkscore=0 adultscore=0 spamscore=0 clxscore=1015
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2512120000
 definitions=main-2601090064

Add RISCV and RISCV32/64 strings in the in processor type and ISA strings
respectively. These are defined for cper records.

Signed-off-by: Himanshu Chauhan <himanshu.chauhan@oss.qualcomm.com>
---
 drivers/firmware/efi/cper.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/firmware/efi/cper.c b/drivers/firmware/efi/cper.c
index 0232bd040f61..9d591a294327 100644
--- a/drivers/firmware/efi/cper.c
+++ b/drivers/firmware/efi/cper.c
@@ -170,6 +170,7 @@ static const char * const proc_type_strs[] = {
 	"IA32/X64",
 	"IA64",
 	"ARM",
+	"RISCV",
 };
 
 static const char * const proc_isa_strs[] = {
@@ -178,6 +179,8 @@ static const char * const proc_isa_strs[] = {
 	"X64",
 	"ARM A32/T32",
 	"ARM A64",
+	"RISCV32",
+	"RISCV64",
 };
 
 const char * const cper_proc_error_type_strs[] = {
-- 
2.43.0


