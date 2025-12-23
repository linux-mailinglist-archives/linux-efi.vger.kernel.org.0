Return-Path: <linux-efi+bounces-5917-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3464ECD8D24
	for <lists+linux-efi@lfdr.de>; Tue, 23 Dec 2025 11:34:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E0BB53064DF2
	for <lists+linux-efi@lfdr.de>; Tue, 23 Dec 2025 10:31:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 001E436B056;
	Tue, 23 Dec 2025 10:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="TRFBtSXE";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="E8+1k9Kd"
X-Original-To: linux-efi@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8686736B04D
	for <linux-efi@vger.kernel.org>; Tue, 23 Dec 2025 10:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766484651; cv=none; b=WMsiWL8reJhM7cEIoSnctQjvrfCBYEe8oWD+muAunz0Jt2DhmY+YLEy4S4bw0/o4n0fTK7k+xAQgCuuQZZgpSXSrG6GkWRICh7JHVAZwiWZGS4gPpQcfazXxL77ic8zcnEG7Q9Vr9K4lgwG7Zd1uLzx0eqHnTL/9rjad3t9J0/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766484651; c=relaxed/simple;
	bh=gDKCTXSHCoUHgGjGdPVsqCxYHy9ab2q8i18avjQ2PS8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=T4ymCAmRRBjj1KDK1rd1zv6TEzGgxs2dl5xxHQ0JGLyCdYsWfiDkcl8qX9t7qEhvSdvxnjd/CTAG95MRtIDgLe9gUEJ6foIJqo0R05eDhoQQBgU8/y3hzRfa0+6Sk0MClY2vARTVuRTGH+s4aLn6O867xsiF4mXaM5DRWCyJ/lc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=TRFBtSXE; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=E8+1k9Kd; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BN9iejt1568957
	for <linux-efi@vger.kernel.org>; Tue, 23 Dec 2025 10:10:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=NfyaqrUWeOY/Ypu7+0uzad8YzRbjGlo4N5a
	iYxdoQ2E=; b=TRFBtSXELDfkIktDSxyGZP9LTkvtlh8B2MFn6L9qIkaTRcOmrrJ
	eDHB/uTKtiHInAKz/5xqPIl6DOUeXKZ9RqAaS9C+n57f0d8QGHyUhtDkOyq5OyKm
	yqYYjvi3/wleOrzyVuCrBNAGFpyAQ2+dv2ccJPfiuC6GvLZGWnUpN5rvXu2F1G09
	4iPfDQVqWK9icfElkFQmmz1er0zuGYyuufnGrYx2XMz24xPLEHy7Tp5zqVTrlfRj
	jL4NHnmF0Sh7WClX2/CRebBQ/ue0BArcAgSY5rTAC01WK3I2xOWhTCfEqGu4CuJ1
	1cQ5VLGIhJHr0I+PeQWu2lpKUaXi9mpeclg==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4b76yy387h-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-efi@vger.kernel.org>; Tue, 23 Dec 2025 10:10:49 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4f1d26abbd8so130973371cf.1
        for <linux-efi@vger.kernel.org>; Tue, 23 Dec 2025 02:10:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1766484649; x=1767089449; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NfyaqrUWeOY/Ypu7+0uzad8YzRbjGlo4N5aiYxdoQ2E=;
        b=E8+1k9KdhgWUbMLZraXbbvHxn8GcsrNOM/FRVFLE4ELPkaFKpMifq5iX+fViB1bZma
         TlgZwn+rvt/WvMzoy/qJUIt+O3lWb2LdDYYiboCyvG3q3CwjjbVkxFw7ZCNGfkSMyKWl
         W7ybVf7ZG+gVVas4sZQ9pE74aNMm8fCTObYzoK1PTQWYsjnBy2i1RS8l1Jvsoz+I2kP2
         zVji75eSWdjbBOxZs/stOD2utktMqkZW0Dz7uv4zknctJ/jij8do2c7en4f9yrLAgX/u
         2v8e7gE4TSNpqYKIR2Xww3A35YERg1/xnwbQXnuqttHcfzS6Qeyazq40Jg/pRhxxrvF2
         V3Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766484649; x=1767089449;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NfyaqrUWeOY/Ypu7+0uzad8YzRbjGlo4N5aiYxdoQ2E=;
        b=VZnJGkSVB/6JC9vkOV1+NTBUYcGetK0jClQgilO9pdyrbnIWtTFwXIoIKLJAMY0ZuR
         lwV6tRpCpIIy35aDX10Ooq3Jx1bCo6tSbuPFOCdPCiGht918A/A9KBCH3UDsKO59fekD
         9fTrgsjV/xs0X2Zdm1bImjGliFN3lYOgtjBYrFIvYex8vGNSbCsTBzlUXgs//8ZiFwDe
         ERkMj/6PvwoQz9jAaEi7FA6aMGUf+43R2onzm+0fIbKCde9SeWhMct+VGdxwppxVtXz/
         lczTh26cM64Gy0iYGWEO/8CSWjIy5kok4lAqKaqiNREFKhww5I2Hr2zoCOhrDFS3kDk+
         LyRw==
X-Forwarded-Encrypted: i=1; AJvYcCUyGJYLDuZ+mX659cpUHQFjvy4WLljbCcNj+JtH3mTb4mHcpsDQmiAAbcuUh1HPsEDmclk1wPQdSK4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGc4nPTyUZU1P90iw/AHA2e97yobK5U58Vx3y9CFgr53oDgm2b
	u7cadech+iA5xKaRHOqNhZQTxdb3QAvBFkUagxZTHG1EP6IHaIPjwnRSyUaHyajcEuK225nJE+q
	MBJawPPd3sXXCCsE/+jE2owa8G4dd+E9Y15XiY1pkq13Px1ybkjeQShkk/mTeJ3I=
X-Gm-Gg: AY/fxX7BSl+OTeleAFSbhh713cOJ2xRnh0k1TKJi0z+wHxy8Hw2vbwhKe+595Nqanu6
	5FZ109EYku5jfCu/kEqfcba7BhPyQePxyukXNjxfuKnYTVINP1MZLul8Ib0pHApHHlyVz9wftHj
	86lTVr38ZqT56FNVPswV8ST9EqzjjptS8RRmE8RThxD6KqJ0vkCL6aH+Bv9XTmApu0JmNY5GxXB
	iTBJSSuiLmmPJGP/FcAJyQrhzIzETpltKFg7HxamhLY4/rxwx+P1n0a//48LLynDkb/qTXB5zjK
	7Tq6Xw5bjTW9Igv1Ss8nAhOEDEUWslsqkKaian3bTRB+TSFA0DVYUsZXeZDYlaMDGQNbY0KQpBd
	E2NJF5PuEHUUQhmls+t5t2HJDQOvui26d17r1H6ABRinWT+AbEETBpufQj1BAQ14VqncRh1mBkd
	lRUg5YaS2mc/mvBXiJo1B/Yc0c
X-Received: by 2002:ac8:5fc4:0:b0:4ec:f4b9:f475 with SMTP id d75a77b69052e-4f4abccecbbmr185476171cf.15.1766484648869;
        Tue, 23 Dec 2025 02:10:48 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFSObLtcdfdlAgQ2U7p+YFPe1TF4Hffdby5mas4uFSxlcAypz+jshMyNwHWosId2S4kGtzHvA==
X-Received: by 2002:ac8:5fc4:0:b0:4ec:f4b9:f475 with SMTP id d75a77b69052e-4f4abccecbbmr185475791cf.15.1766484648355;
        Tue, 23 Dec 2025 02:10:48 -0800 (PST)
Received: from shalem (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8037f37ee8sm1329878966b.59.2025.12.23.02.10.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Dec 2025 02:10:47 -0800 (PST)
From: Hans de Goede <johannes.goede@oss.qualcomm.com>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: Hans de Goede <johannes.goede@oss.qualcomm.com>, linux-efi@vger.kernel.org,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Javier Martinez Canillas <javierm@redhat.com>
Subject: [PATCH 6.19 regression fix] efi/libstub: gop: Fix EDID support in mixed-mode
Date: Tue, 23 Dec 2025 11:10:46 +0100
Message-ID: <20251223101046.16334-1-johannes.goede@oss.qualcomm.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjIzMDA4MCBTYWx0ZWRfX6XLUsw5s6Qz6
 M+gIrJvqXiQW+SLmokI89IYKoYvUWdLsxleZov09BDbSanAqzUelD8DRnsZytRcig479vd/pDqC
 0Hlbf5RkDSX5pULdlbK4ShREhVikKxBupA1iF90OVHjZI1tOkqf18W1ctPG+9BUARZvtXljGaIL
 5viJniqGITlRwK+TYRJ8kogFN0Yt5J9sKMsKqEOr43LhHM8H+CD59ETIKviCkWeyl2j9wvtFcTk
 l6ofSOs5C+/LlDp/empqVH/KeGh3OSKtifgPczkgWBs8kJ+r8fYyItMDVZ5A9X7TGi2W/5UfcxA
 uc4upU7NBO9qBgSWN9TH38lkpkpgFdpJa2Gf5uKAVn0tR4F7MERwePkTSsIOuOyTQOdLz2QXu9h
 Y0J7TFfwc9w2ODSaiR+FVgVHpuYmOS0+K0BYzHtbd6MRKr6SyZW7Wj4tRv3VIrNRglCl955L41P
 5aeKJzl67YN5AWX0efQ==
X-Authority-Analysis: v=2.4 cv=Zb0Q98VA c=1 sm=1 tr=0 ts=694a6aa9 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=wP3pNCr1ah4A:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8
 a=Qeq5G1H1nQ1l2CRTfyAA:9 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-ORIG-GUID: S9msoiCNn0w0QStbhO9kOKHNkSmQv0y4
X-Proofpoint-GUID: S9msoiCNn0w0QStbhO9kOKHNkSmQv0y4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-23_02,2025-12-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 priorityscore=1501 malwarescore=0 impostorscore=0
 phishscore=0 spamscore=0 bulkscore=0 adultscore=0 suspectscore=0
 clxscore=1011 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2512120000
 definitions=main-2512230080

The efi_edid_discovered_protocol and efi_edid_active_protocol have mixed
mode fields. So all their attributes should be accessed through
the efi_table_attr() helper.

Doing so fixes the upper 32 bits of the 64 bit gop_edid pointer getting
set to random values (followed by a crash at boot) when booting a x86_64
kernel on a machine with 32 bit UEFI like the Asus T100TA.

Fixes: 17029cdd8f9d ("efi/libstub: gop: Add support for reading EDID")
Cc: Thomas Zimmermann <tzimmermann@suse.de>
Cc: Javier Martinez Canillas <javierm@redhat.com>
Signed-off-by: Hans de Goede <johannes.goede@oss.qualcomm.com>
---
 drivers/firmware/efi/libstub/gop.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/firmware/efi/libstub/gop.c b/drivers/firmware/efi/libstub/gop.c
index 72d74436a7a4..80dc8cfeb33e 100644
--- a/drivers/firmware/efi/libstub/gop.c
+++ b/drivers/firmware/efi/libstub/gop.c
@@ -513,15 +513,15 @@ efi_status_t efi_setup_graphics(struct screen_info *si, struct edid_info *edid)
 		status = efi_bs_call(handle_protocol, handle, &EFI_EDID_ACTIVE_PROTOCOL_GUID,
 				     (void **)&active_edid);
 		if (status == EFI_SUCCESS) {
-			gop_size_of_edid = active_edid->size_of_edid;
-			gop_edid = active_edid->edid;
+			gop_size_of_edid = efi_table_attr(active_edid, size_of_edid);
+			gop_edid = efi_table_attr(active_edid, edid);
 		} else {
 			status = efi_bs_call(handle_protocol, handle,
 					     &EFI_EDID_DISCOVERED_PROTOCOL_GUID,
 					     (void **)&discovered_edid);
 			if (status == EFI_SUCCESS) {
-				gop_size_of_edid = discovered_edid->size_of_edid;
-				gop_edid = discovered_edid->edid;
+				gop_size_of_edid = efi_table_attr(discovered_edid, size_of_edid);
+				gop_edid = efi_table_attr(discovered_edid, edid);
 			}
 		}
 
-- 
2.52.0


