Return-Path: <linux-efi+bounces-6143-lists+linux-efi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-efi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wDogDciokWn8lAEAu9opvQ
	(envelope-from <linux-efi+bounces-6143-lists+linux-efi=lfdr.de@vger.kernel.org>)
	for <lists+linux-efi@lfdr.de>; Sun, 15 Feb 2026 12:06:48 +0100
X-Original-To: lists+linux-efi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B5C013E8E7
	for <lists+linux-efi@lfdr.de>; Sun, 15 Feb 2026 12:06:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 56496300E155
	for <lists+linux-efi@lfdr.de>; Sun, 15 Feb 2026 11:06:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADFEF2C08AB;
	Sun, 15 Feb 2026 11:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="S+XsWXtN";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="N73rRdBj"
X-Original-To: linux-efi@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3280B2DEA93
	for <linux-efi@vger.kernel.org>; Sun, 15 Feb 2026 11:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771153596; cv=none; b=Z4rX7y97C3Upeiz7K4m9Nc+zffLBFZ6CZCti0stne4hO74aMcnoLv5yxSknJwhmdQORddPh47go65hh6pX+JgCkJJ5Mkh3CnRqWe13rFczCZKgx2Yva9dHVjVSEtdczfd9glQ2NtE6V/iN43CKn4DBNK8MwKUvehuRnsXOWc6ls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771153596; c=relaxed/simple;
	bh=NP94FmMc49hVak9d84xroc99UMOfASUZ7FO4Vb9UwNE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=haNzwRGToo5Zz9FrbxFanvbIGDY/gSbMjuRsnb0A20p8X/c7s1PuBJP7e7srBfhzIuvhWQ/G4MKpGjF/LZ4Z1ACJLFATDrP5714zM/CgRsTgznzrR6Y84UIRGpNmmQLXyDyMQMnoyjbPNAijeI2sJ4rBt7r5d4w8IlHKYZfDlMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=S+XsWXtN; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=N73rRdBj; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61F8l1vY3925030
	for <linux-efi@vger.kernel.org>; Sun, 15 Feb 2026 11:06:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=ld1npyEylhh9T/ZrLUK2KA2uppN+ES3kJsT
	5nxT2auI=; b=S+XsWXtNwq8KK4YXODBXvTA5hKPUNWG6nwUU3T0pjsMNAQTH6dY
	ZdE1pl9ceKZYKmugtQawlKT4wI47oTgXiCmEIVReXm25gGSkeSWJwQI6BDd4u/MR
	xRnjxlpzRs84j+TDjfamMoT+Sas4lQQc+wRqSe6WQShjzQkNZ8mEg+6EFgq8rt+c
	22JmorGW4Q4cKLYb7KJiYQCXkel9P5Sa1Iav3dcQBvFT2Ln7nXoDNZXRG8H1MZ/B
	Jv2vyaAJP3zbk2gUfurCOaYoZGMxqmwOCuBgZpy9qkhMHG31CZf8MwUg4hs8/18Z
	5kAd2RJk0MEn8qQvB+bTkguUmgYWNIAwkWg==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cajb8t25q-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-efi@vger.kernel.org>; Sun, 15 Feb 2026 11:06:33 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-506bfff75edso66309981cf.3
        for <linux-efi@vger.kernel.org>; Sun, 15 Feb 2026 03:06:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1771153592; x=1771758392; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ld1npyEylhh9T/ZrLUK2KA2uppN+ES3kJsT5nxT2auI=;
        b=N73rRdBjkfALEPAWcIl+KoJI5x22TUU/fL+xIPtn/jNTBMY+MJdZEAxvaedfSyw3R1
         NkvM4cDaI45LPop1q0oqh2eY6d1zZrszcIAYxBthQAONHp2bpm90tsmmfevp2cWk2TIl
         oHsKazk67uP573KXNWS8yDW9x2N2bL+FPd34UbfHsb1HJdZrjIqQqFJwH8iPq//9KypX
         lGFd1lUpn5LaztBNlRv6JMugEUJ07kSX3Gqg8MvZ7XNt9ZzBUxHH0fjDdaDGOhobo44x
         gt0sp3+pWBfqDOip9PETjaew9JIEjW8X/ZJzzb6FMU9y2hsI8cLD3n1BYM6YGvXD/R+w
         WTmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771153592; x=1771758392;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ld1npyEylhh9T/ZrLUK2KA2uppN+ES3kJsT5nxT2auI=;
        b=qJN7jAsFp8um3Qj5Zt8ggbFmvCHzM9km4ym/QmdRezq02fIDK7TGPyR8/brQ3Iu2zm
         OOUhOGec11b2Ng0udPaPvbgOCEgvYQ85bMU0I72WJlYbNVbeEC4G9W3WpsMMfHoPFdGn
         5qwYv7QUUofXwvCydkVf5BGVTeqNisE18m2bi1O3GMPX+S4Tstu20urR4T8jxMruJucq
         5Xhaf+UivYWAdMgswimBIanRVl/wgAOAVKaO5AG6viAB5MDoURHajh4llt4R4p+ks55c
         2tRXcbCVlkQV8GLnL2bToDDc8LeVjzWIxGcXasPafmuQckBn6Ht3Xmsifq/QjBuSdwL+
         d4cw==
X-Forwarded-Encrypted: i=1; AJvYcCUawNMhPHlgom9O92bzy+u3lR0w2UuHpvDEBS5IJvmGEcVMzF86cqeoyOXrYJf6Hc6AZNxXqIibc3c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5pSW6GcDiFgRKTCUvax64hCnZ11rXkzDH0C17Pot8zj+8iHW4
	kNeDMMClMJdbYcsUDMHuMtl/ifo1GSm57ZbGk7sxz0nm2Kr9Koxaxi0b3UXxG+lMS689ZMw4fM8
	lkk3N7qW2oRMxiq6WlCaZW2SsD21Yn39mFx/cMGyvUdbA8MkhwCXefRmFl263kSA=
X-Gm-Gg: AZuq6aIdh0F3HoXvvqKObrU0DbLzTc945v/ik6vKQsYdPDhC5lGK/we1kEihq6BkrUA
	nuqcUrDgYZtEt2QAiClIt+HotlkzBrVHJZltf+vudr+A/qQMVXBVYril7M/d6pkTCeOd/Wgiepc
	zi5Qj9ry3FHeDH1QQEkHwUa/wDpWkK8A4RSn8aZMWIUfG3v+jn2DqOFH7x70tRsqWCJVXhErkiH
	s7laNEFGZNNvOinVzEl2RFpa+Y9/NyE0ovcBkUMlxZ7VQUJ2d+AJFLEYG1KJbxO7fseZrSOB+cN
	jY4NjzVnoKVeKcghLK6QBFEquvOU7yZIuSo9cMmlz4gAKxL5/PdQ4Zqz3Ov/HgzrWM7G/MU5GKq
	qKDHd2nVtXlYBXIgJ8wEKtYwzDKfn1bhycQ5nJg==
X-Received: by 2002:a05:620a:7081:b0:8b2:ec00:7840 with SMTP id af79cd13be357-8cb42268fb7mr859964885a.27.1771153592475;
        Sun, 15 Feb 2026 03:06:32 -0800 (PST)
X-Received: by 2002:a05:620a:7081:b0:8b2:ec00:7840 with SMTP id af79cd13be357-8cb42268fb7mr859962585a.27.1771153592073;
        Sun, 15 Feb 2026 03:06:32 -0800 (PST)
Received: from quoll ([178.197.223.140])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4835dcfafcdsm546360325e9.9.2026.02.15.03.06.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Feb 2026 03:06:31 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
To: Ard Biesheuvel <ardb@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        linux-efi@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Subject: [PATCH] efi: stmm: Constify struct efivar_operations
Date: Sun, 15 Feb 2026 12:06:28 +0100
Message-ID: <20260215110628.34293-2-krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2165; i=krzysztof.kozlowski@oss.qualcomm.com;
 h=from:subject; bh=NP94FmMc49hVak9d84xroc99UMOfASUZ7FO4Vb9UwNE=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBpkai0cmoweuXzmNdkt3cUKsm8kSCLQVJPu23p+
 dCZSm7zbAmJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaZGotAAKCRDBN2bmhouD
 11qAD/wN+jA1lzX6+fvH+7NvijyyXmKjI69j+7amUOgM5sbk570RGatIFifeiMMYCzNsjRtka1N
 SK1h155UeEuyH4Bh28xMW0yl3B4RbpKRBgecF8bJOoauDz6gj89z70NAhEoCXnlMQzyliGE3BKi
 Ahxw8Ny/zGlGitabsYrEgLDKuVSld04+JP8Sog5HdJ35M1hsyWuZXSNr+jqW6HxZMPq5fhBdzXr
 5u07sXCHRdxtXIs+A6LZdb0qYJ3D3oSR874npKfRbML/aPlxh7DQXJPoWBoDL65GifRkJaHhZl2
 MjJDpmk/7UdZIzOdP56MOfqQlImW+obhbofUzlCs1cKDpZd8hVCB7LOBYj+bJw2dfZR5nGwgGuZ
 MKmrUgz9ADLHW7MgUaHtCdjIKKMF+PoQjoN1Zzo30F3SVWfda9kAEQK8GxotrYMrO4n6LI9kcAL
 Fwl8MNE2IFEYm5DVap6C+VDkyMhbmTb84uEMDJYMHqastkqmUxy05JsGSD217Kev8/4HnhENdLN
 HINqvMPYNNQTDLiPSGaaDq8A2zGrjc9XKAUK9kOHbF2DT8UZsu+SuYHn0DHl5L7anJl4Itr+pii
 caB1cZK16piHfC546QaES/WzkbiqD9u/sxAYzvAYEfsLIlrT6dpd6lKsaXed1zbkbjcXudDC5+I fgr4KP1y45xlKHg==
X-Developer-Key: i=krzysztof.kozlowski@oss.qualcomm.com; a=openpgp; fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjE1MDA4OSBTYWx0ZWRfX7V2pODYp/psf
 LgpoK/IVzc/t6QbQoUCmWC8O3NLBIrSfAQ+1zWzd/m+zYhoimmsJUSgb/IOgDAEX1FltKYl4Qy8
 SPP5ehD+R75DrZtSmyor31d1WM2JC/OD/leRS/Zyo6SRGaPrTbjHV4MuDNmSDBeNGuGCVkZBpu6
 SBq7rYqYfx4cKDhPki58dxy6moT9C7hHiRfp/hnTTvOC4aH6eGHOSOm9ItSSHhb6OFtaenh/24g
 3+3iBPoPc4OePSZ5EcwIWmLn9+i3vS2Jnulv++n+ZSpu06vbAZnYb5XL0p5m8wweE7Xhewj6J+s
 wVrKH23roiFS61RoCaLYtW8qaxNYoXxceyeMuBQVM7rT3xjHgu3yx0+hBYNENyi/TObodSQQu0w
 +yR7WTo/zLRDpYY5GNrVVKiiCaKh34fNb7jnTUGp8recBDeA41Dfc+AMkPiDLeswJ88CmXK2E7z
 Jqe7IXyb6uMh3eTRa5g==
X-Proofpoint-ORIG-GUID: ARegXh3bFUQSR0LSO-XU_5mYjzhRqdTK
X-Authority-Analysis: v=2.4 cv=Pe/yRyhd c=1 sm=1 tr=0 ts=6991a8b9 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=6nO30s3o7FuWeffXwhKHTA==:17
 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=EUspDBNiAAAA:8
 a=NNID--eWxax2qouwXSIA:9 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-GUID: ARegXh3bFUQSR0LSO-XU_5mYjzhRqdTK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-15_04,2026-02-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 phishscore=0 lowpriorityscore=0 spamscore=0
 bulkscore=0 malwarescore=0 clxscore=1011 priorityscore=1501 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602150089
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,gmail.com,foss.st.com,vger.kernel.org,st-md-mailman.stormreply.com,lists.infradead.org];
	TAGGED_FROM(0.00)[bounces-6143-lists,linux-efi=lfdr.de];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[krzysztof.kozlowski@oss.qualcomm.com,linux-efi@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:email,qualcomm.com:dkim,oss.qualcomm.com:mid,oss.qualcomm.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	TAGGED_RCPT(0.00)[linux-efi];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 8B5C013E8E7
X-Rspamd-Action: no action

The 'struct efivar_operations' is not modified by the driver after
initialization, so it should follow typical practice of being static
const for increased code safety and readability.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
---
 drivers/firmware/efi/stmm/tee_stmm_efi.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/drivers/firmware/efi/stmm/tee_stmm_efi.c b/drivers/firmware/efi/stmm/tee_stmm_efi.c
index 7b04dd649629..3bea2ef50ef3 100644
--- a/drivers/firmware/efi/stmm/tee_stmm_efi.c
+++ b/drivers/firmware/efi/stmm/tee_stmm_efi.c
@@ -14,7 +14,6 @@
 #include "mm_communication.h"
 
 static struct efivars tee_efivars;
-static struct efivar_operations tee_efivar_ops;
 
 static size_t max_buffer_size; /* comm + var + func + data */
 static size_t max_payload_size; /* func + data */
@@ -520,6 +519,15 @@ static void tee_stmm_restore_efivars_generic_ops(void)
 	efivars_generic_ops_register();
 }
 
+static const struct efivar_operations tee_efivar_ops = {
+	.get_variable			= tee_get_variable,
+	.get_next_variable		= tee_get_next_variable,
+	.set_variable			= tee_set_variable,
+	.set_variable_nonblocking	= tee_set_variable_nonblocking,
+	.query_variable_store		= efi_query_variable_store,
+	.query_variable_info		= tee_query_variable_info,
+};
+
 static int tee_stmm_efi_probe(struct tee_client_device *tee_dev)
 {
 	struct device *dev = &tee_dev->dev;
@@ -558,13 +566,6 @@ static int tee_stmm_efi_probe(struct tee_client_device *tee_dev)
 			  MM_VARIABLE_COMMUNICATE_SIZE +
 			  max_payload_size;
 
-	tee_efivar_ops.get_variable		= tee_get_variable;
-	tee_efivar_ops.get_next_variable	= tee_get_next_variable;
-	tee_efivar_ops.set_variable		= tee_set_variable;
-	tee_efivar_ops.set_variable_nonblocking	= tee_set_variable_nonblocking;
-	tee_efivar_ops.query_variable_store	= efi_query_variable_store;
-	tee_efivar_ops.query_variable_info	= tee_query_variable_info;
-
 	efivars_generic_ops_unregister();
 	pr_info("Using TEE-based EFI runtime variable services\n");
 	efivars_register(&tee_efivars, &tee_efivar_ops);
-- 
2.51.0


