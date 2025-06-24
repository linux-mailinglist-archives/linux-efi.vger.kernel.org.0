Return-Path: <linux-efi+bounces-3961-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C2A60AE728B
	for <lists+linux-efi@lfdr.de>; Wed, 25 Jun 2025 00:53:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D62E3AB46C
	for <lists+linux-efi@lfdr.de>; Tue, 24 Jun 2025 22:53:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D13325C6EA;
	Tue, 24 Jun 2025 22:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="UpsLtGOp"
X-Original-To: linux-efi@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7D1925BEEA
	for <linux-efi@vger.kernel.org>; Tue, 24 Jun 2025 22:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750805610; cv=none; b=aex6DVNxVR9q6FnoBePJyIp2aaN/ho+jIaCK4UbHFOSd9hgqd//ReeDWKPqY2vWEdtbx153gyBiAWzHrOtOiEe3DS5ChkVu3jpYX/wVNLksv1D03aRaZLw2yx7achtHxf4Qj5I5HDcEG7RMul4D5MLMPtVpUoLhFYko89p++Rk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750805610; c=relaxed/simple;
	bh=t/rZg2mXoS35Z6g/Fc1ahHAw8Dong0aRc6LecgnXaBA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=J8M523K9JHwI/db3dQUrY27M2FqVMA84T+pRLzwDcCSV8VHgCpUmIh+TG7r51sHFCj0CVIQdnhVPW0K4UXMHZ5T28t9UoxqFoavKAMHCf2/EeCXHtpXbKovMIgqTjCFFyh4ZZhrH4YQSEoKBPsabV5CagFwpBuWT3VDh5/SV6O4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=UpsLtGOp; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55OFNnM5020776
	for <linux-efi@vger.kernel.org>; Tue, 24 Jun 2025 22:53:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	/47YVhRJHDkRQwljfohl4e6sBDrvrN8mrp2H+cyoRUY=; b=UpsLtGOphCfC/MZK
	CdD1TgsjzeHahCrZkUMFA/+NMhTfGkS+ZkCXATYs9GWw6WcH3wQm3enIdAqN6LM4
	KiM9gnqtHPvtr9nUi0N4rE/96Uok3wGV1xpZi7Z+EcMiOlJ1m3/r+TzDLHad4spm
	rICWHPEMsyNebWaBTRhi9ltzHhFRy1v58gnPoSopwHCuA8Pf6G8Gq/RqEiC0rjGD
	3wuaSZYs0ecMewsY2hEMLwtX88QLIAuUZaPH82UpcAMr0isD5j1rxmmPSGHi7/uV
	6Wxk37sQGvq2vx5zhnVRzGI70YWMRVArA9ujlY3Rbx7dZYR2DJ7BA7m8q48uJ08+
	3ytqSA==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47f4b3wns8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-efi@vger.kernel.org>; Tue, 24 Jun 2025 22:53:28 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4a71914dd25so137127841cf.2
        for <linux-efi@vger.kernel.org>; Tue, 24 Jun 2025 15:53:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750805607; x=1751410407;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/47YVhRJHDkRQwljfohl4e6sBDrvrN8mrp2H+cyoRUY=;
        b=L8pPxEwIpR7Y7ygNpynUjqozTrQpdBGgcagylV7LNgEQxyr3+T0a4v7EcbwqdjlOxk
         tYUQ34w70Bs0s74nY3DcGffNB6G8NUAXqrSW576Viq03N3bIZqR8xZV3rk3ZHTQmiF2l
         RckO2NfB3HrQfnAmfMdH93DE3Vtvrath2KqI0aNmoJj9I1vOtFrE5vy62mYNydRtt361
         zbZqIywP226CI7vxI2DL530N0zinmu+uuHoiGuwq4f7RsLRMSqJFwzwghMqx9UXfkeyn
         Ejy+1WLyN8gfR1hrSbWIAFGB7VKf5dqDKMHFLUmPno0ApxDTdj0lRzQzKuULWXbFasJn
         le4A==
X-Forwarded-Encrypted: i=1; AJvYcCWmusg8paA6x6AYjn8+krMxFcokIryM+PlR51SutAWL+MBAELE++EQIM8Wi4h8WYrIqH7EnuHgLyJs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxdE0FndcaNX2sxlgFnuvu0NC40ZwsOSNLhKvbgiYCTmJGh939w
	3+jkbQVGxsLajnFalYR+HKFYh0YnOnYes5VJmkG28SyZYSMta6/Di3ZaRkmgZqOM1FdG6fS04cc
	yP6PDp2d+hvYpBsQha2qaVJi4cfeX6eSDx1l8uivou+tAbfxp9lD84EoV57slOjI=
X-Gm-Gg: ASbGncvvrXRXfGnUJHm6VdFTpu+yBA4ASEGpC27kYCZwdCyd1+/nDaEQS4SFuwgdu4O
	YtlmSh52YmAl60X3jA9JUUDRApPQesAsGXarZaTkFg0cZENN0DhgheYdTpnRwsHvycaSH752m7R
	u4DuKODO5cl2SE9irQAHtFkyYlADrBBNxyyJHcxtel0cR1JR0NBsNg72qSqgu++IFYv+3b0U7L0
	yPbbxZ7K9cMuze+/ndMqkz4I/u4iS42JNy6P8DjI2Zao4ZOi0CH8JNl3Axbml8R00Pf64aonHsD
	n+nBzgby8HFlgAZmGMh+0FIR92bZnXZDrrPJo+Z4k8em6ykin53p4eFb+vRz8WNVS38Dvt1i1d3
	WzwTkIaaCJcinIk7X5CyjUP0MFAl26zU2LpE=
X-Received: by 2002:a05:620a:2815:b0:7d4:6f:a3f3 with SMTP id af79cd13be357-7d42974bbd3mr120817285a.44.1750805606651;
        Tue, 24 Jun 2025 15:53:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG94M3DQjJxjlOh+Wa7ZVDN2Ra0eLm5I+n3Okv+Uk1a/lJierkVbRDFtP5lW0t+YOyOA7SF3A==
X-Received: by 2002:a05:620a:2815:b0:7d4:6f:a3f3 with SMTP id af79cd13be357-7d42974bbd3mr120814485a.44.1750805606292;
        Tue, 24 Jun 2025 15:53:26 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-32b97f5980bsm17843851fa.7.2025.06.24.15.53.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Jun 2025 15:53:25 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Wed, 25 Jun 2025 01:53:20 +0300
Subject: [PATCH v4 1/8] efi: efivars: don't crash in
 efivar_set_variable{,_locked} in r/o case
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250625-more-qseecom-v4-1-aacca9306cee@oss.qualcomm.com>
References: <20250625-more-qseecom-v4-0-aacca9306cee@oss.qualcomm.com>
In-Reply-To: <20250625-more-qseecom-v4-0-aacca9306cee@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Ard Biesheuvel <ardb@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: Johan Hovold <johan@kernel.org>, Steev Klimaszewski <steev@kali.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-efi@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1258;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=t/rZg2mXoS35Z6g/Fc1ahHAw8Dong0aRc6LecgnXaBA=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBoWyxivcQKN9slXayTHROefKCDktNqjipS1qirs
 xkySAckA9+JATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCaFssYgAKCRCLPIo+Aiko
 1S5PCACYyB2xDS0iQyM+NvelIhDHfQwbdUlUaEjQVCCSve1uwzQm/XLjA3raAXOL+c0KmJtILQI
 rEOrfxnDr9JDHnVkBtOpy0n3O8UAmA7jXvjl6uC0eFJJaSmChTl+tIOc+2U3qKHv2YgtPIjB60G
 GpTQdxl/X27iK9dHsROC0Xs44R05PsOlrsnqZGynae9K/yHc/P11ES21H+crbemKyW94PS+AyI0
 IIfUaLZrbZVe2OWBk5OAv37znQIV02F63t43l2cx7u225Ra3V5W6E2QlvGYcEcVcBLpXUxDU5/S
 66JuoPiykkS2Vynu1gZ8bY55D1WC0SItw8fZdmAaaAktc2ae
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjI0MDE4MiBTYWx0ZWRfX4O02ZyGUrWYQ
 ib1CSQ5gt+1/poV06EaMR7oN3DqG/W06pL6PSMfm+TaqMj7Mq7u4nBWA8NcmyC+OAcsrv4quocJ
 iQDNnXbt733zNQf60Ua7+FHMw24+oo7VSUCi7RhmVV4mgxUqTeyLp66oKnbCZ09kaDJxDqav9PH
 els4Mh9o7sMH9GhTViKr8J2eSuXZ7Csa57/0VEosgYQl8fjO/r0cWfV/ZtY5ALhrt53OvepzsBW
 6HKCNmr0Q+i5k/YFuvTnbmUAn02x3z8+VpkaTdOa70LyVCq4dg89/389weQeqXb8h8/tQzMOLdh
 fsMo5+qKbxvBo2gjY3rlVlxvCo4qvZ7oBHXPGYog70t9S2jIVNu6j6NIaDL9ib+MEsxWOyVFQyH
 CyhQE77XHG0UiUg6d5JbCCM+To0qzpQ0b63n68gN6PVjHP6HOrMsvLcSQfRhcfnNJMbujq8E
X-Proofpoint-ORIG-GUID: GdAa5JUF_-ggIx9HjJ-HO9hYh_1M1e1Z
X-Proofpoint-GUID: GdAa5JUF_-ggIx9HjJ-HO9hYh_1M1e1Z
X-Authority-Analysis: v=2.4 cv=A8BsP7WG c=1 sm=1 tr=0 ts=685b2c68 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=6IFa9wvqVegA:10 a=VwQbUJbxAAAA:8 a=zitRP-D0AAAA:8 a=EUspDBNiAAAA:8
 a=2-Wz6HayXEhRivmEhXsA:9 a=QEXdDO2ut3YA:10 a=uxP6HrT_eTzRwkO_Te1X:22
 a=xwnAI6pc5liRhupp6brZ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-24_06,2025-06-23_07,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 mlxlogscore=999 malwarescore=0 spamscore=0 bulkscore=0
 phishscore=0 adultscore=0 impostorscore=0 suspectscore=0 mlxscore=0
 clxscore=1015 priorityscore=1501 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2506240182

If efivar implementation doesn't provide write support, then calling
efivar_set_variable() (e.g. when PM8xxx RTC driver tries to update the
RTC offset) will crash the system. Prevent that by checking that
set_variable callback is actually provided and fail with an
EFI_WRITE_PROTECTED if it is not.

Fixes: 472831d4c4b2 ("efi: vars: Add thin wrapper around EFI get/set variable interface")
Reported-by: Johan Hovold <johan@kernel.org>
Closes: https://lore.kernel.org/r/aFlps9iUcD42vN4w@hovoldconsulting.com
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/firmware/efi/vars.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/firmware/efi/vars.c b/drivers/firmware/efi/vars.c
index 3700e98697676d8e6f04f061f447391503f9abba..11c5f785c09364f61642d82416822cb2e1a027fd 100644
--- a/drivers/firmware/efi/vars.c
+++ b/drivers/firmware/efi/vars.c
@@ -227,6 +227,8 @@ efi_status_t efivar_set_variable_locked(efi_char16_t *name, efi_guid_t *vendor,
 	setvar = __efivars->ops->set_variable_nonblocking;
 	if (!setvar || !nonblocking)
 		 setvar = __efivars->ops->set_variable;
+	if (!setvar)
+		return EFI_WRITE_PROTECTED;
 
 	return setvar(name, vendor, attr, data_size, data);
 }

-- 
2.39.5


