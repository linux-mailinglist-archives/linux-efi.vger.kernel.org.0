Return-Path: <linux-efi+bounces-3934-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2061AAE5995
	for <lists+linux-efi@lfdr.de>; Tue, 24 Jun 2025 04:14:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8730E189ADA1
	for <lists+linux-efi@lfdr.de>; Tue, 24 Jun 2025 02:14:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 793022063F0;
	Tue, 24 Jun 2025 02:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="iPHbmBtp"
X-Original-To: linux-efi@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C586185E4A
	for <linux-efi@vger.kernel.org>; Tue, 24 Jun 2025 02:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750731245; cv=none; b=l/n/bBczR67NEgR20WVwaulyHdRSV5kcps4PIA9cgX9wIne5BWFnxtAfghoT9EvWLjiRfT3qAbX+oC/tpftW8G8Ll9FxXLS1ENcDxuN9E76aWfXiXQVjzu4xKErG0rxOXWqWdlZXJ2cNRyNJG7gGsCPbmJpM62sSHeGDKNQ/bJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750731245; c=relaxed/simple;
	bh=tjBly2s6mnuGi9HgjrC+Tb4IXYnpF3vQanWgu9BVuLs=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=hzYcO7ZwHdhukaUmRF4vYLuYnCPhxDEnDLcaR01v5/Tqa2Bekuu9UCVKErKjysSXhqXdr7GhqcnCkc2JgicAqqs2DujKtVBPAPeng0HHJL4+HuZ7IrTGISLDqwybK5G1YTwVlwIaQuxWwheIuV3sBR+5S01Ls+nlL4IjQju7ZDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=iPHbmBtp; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55NKlxuC013337
	for <linux-efi@vger.kernel.org>; Tue, 24 Jun 2025 02:14:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=kHnh6r0zdR77x91Ki7b9UP
	DR7LpEx1EneI2WJIuSQmo=; b=iPHbmBtp7gr+r7qSK1vUgPpRYJZRGIxJQoI4MG
	UCjGDMOqmg7klVEaDxwYG7ha39CFlJP0m2BLgbHvVzNX3kuuH7t/MU/bbiaUrD15
	bqIH6uwmIJxO21T9S1QbiZre8eV1479Ie9v0/Qu5e/FYS+bHi3UtM54e4+yEjqT7
	DziGCjG+0+2NQC5J9ceu8gjMKDEMvfikzKEmHU+MH7nrQr7Hd5sNFcHv/eINSRH/
	tRcDLjotdc7JZy96dhYpPEmbuFPhaF6squYydgbjxd0zbhAJxZvrcMjNqRUlQDCk
	N7ZAyhPm9FUu14qJv3RAJxMcHPCdYusGldnlN+FGO9wzSTJA==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47fbm1ryx1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-efi@vger.kernel.org>; Tue, 24 Jun 2025 02:14:01 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-7c5cd0f8961so981182685a.1
        for <linux-efi@vger.kernel.org>; Mon, 23 Jun 2025 19:14:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750731240; x=1751336040;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kHnh6r0zdR77x91Ki7b9UPDR7LpEx1EneI2WJIuSQmo=;
        b=mps/vfhLEeHdf3Hv+HjKFgRUM5iq8Mkv/KaeoOH0MvFUCpofL9832mGflF+8r8EoPo
         uX/7CLIi/eEBpAXhrhPuYXOpqkAxjY/Cy9mXjgUDmY3itAYxj510YVDgo8944anSCvUg
         LDRMLt1GTKfSeqdT5iHKgRAYuQtSdrN7cOAhvs80QDU8ErgGrzYnrrcUZe8KOIlkcJLR
         HiePJvuE3qhDro9TsLBj7qxnP1TeJVNUx7MazAtuoE01MrqNRHmeKFejZdlaInW7KLAn
         i/Qorhd8MA+dJv+lgs+5JlbeQ6igTLV+S+/emxfFjjzlnJgt1C1HjaNadxVpbaYJMbUM
         o8lw==
X-Forwarded-Encrypted: i=1; AJvYcCWnJqkppKU+f4DJv4nTzodbMYWW9bsKp9ybWumnU5zE4DttOOvVphx/b118EvAqh3mSdgllIy+LxEY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxG4Qz1Zdw/qxMsjqDvTkNGL9b0jxW2LavOM6qHhYvNmoT60sZm
	48wUoyBB0VrO4HL2MQQpiIzdFNzKK3yqgQTNi+EzHV069Rh6t/80O/+QN6HTPukvWtk92SlxzA5
	ONq3HNd/idpiaDx8V6fGvA8s7cXFgaoD1rrp6fDFEhOUExEFIh1XmDMc6WfTX648=
X-Gm-Gg: ASbGncttGHXs4mEkZyx/3dLcImMV8zzSXDFyySUIlASZWMyrba/1E9P+odRNaMVJ6Fe
	162w+OfTH2WdP7ivtXT3sNBDHh8V6XbKnYTsdQPcITSakDY8lfwLPLB7BHabG8cnsif4yQjau2v
	thMaNGfYh3MVois3nQcHgLsVSLGJbAcsusGyYE1n2HoqFhh17Y/agOAUzu2c6WzKgQZQA74KwPA
	KdBiYV1JBxg+AGrLsWS3ZKgBVNin9amMGgu9XL7AInGwO8c9aiITs45XhRrwsjZxbHnN2A3skT6
	Q3kdvfg1+o+20H49bRETVK0CsfK4PJZNT2eb/TxCneYuY4J86Fv/SqoRtetaQqs8xUCRgE116JG
	/1jg++Tb18KwcU0Bb/08Uq6ssc6cpmXnutEc=
X-Received: by 2002:a05:620a:a505:b0:7d4:1ec9:d267 with SMTP id af79cd13be357-7d41ec9d270mr221708085a.11.1750731240462;
        Mon, 23 Jun 2025 19:14:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHGjS5BY0iJ2H+V1C6DQrHqElw247aJkhWGwm0mvZnGfA0ak95N5Osv0qEtl4IV8Urb6agVpg==
X-Received: by 2002:a05:620a:a505:b0:7d4:1ec9:d267 with SMTP id af79cd13be357-7d41ec9d270mr221705985a.11.1750731240081;
        Mon, 23 Jun 2025 19:14:00 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-553e41446e2sm1637764e87.32.2025.06.23.19.13.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jun 2025 19:13:59 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Subject: [PATCH v3 0/8] firmware: qcom: enable UEFI variables on Lenovo
 Yoga C630
Date: Tue, 24 Jun 2025 05:13:51 +0300
Message-Id: <20250624-more-qseecom-v3-0-95205cd88cc2@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAN8JWmgC/3WPzY7CMAyEX6XyGZf8kJRy4j1WHEJxIRJttnaoW
 CHefVPQXlbiYmnsmU/jBwhxJIFd9QCmOUpMYxF2VUF3CeOZMJ6KBqPMRjXG4ZCYcBKiLg1om7a
 19th2jW+hRL6Z+nh/4b4ORV+i5MQ/L/qsl+0H0KxRY3AuWOfsSfe0v8YxcKoTn2EhzeYv7ZQ3+
 l/aoEJP295b5zeqc/skUk+3cC3XoS4DDs93PabpVp7M745wDEK4mGLeVSPd83oIkomL//kLs5H
 u0hwBAAA=
X-Change-ID: 20240725-more-qseecom-379933b9c769
To: Bjorn Andersson <andersson@kernel.org>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Ard Biesheuvel <ardb@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: Johan Hovold <johan@kernel.org>, Steev Klimaszewski <steev@kali.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-efi@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2504;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=tjBly2s6mnuGi9HgjrC+Tb4IXYnpF3vQanWgu9BVuLs=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBoWgnlPAiUDAeHKKGJImPg/+wqx2zOWM4/iRMEI
 Qgpjw25j1CJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCaFoJ5QAKCRCLPIo+Aiko
 1XxCB/4j9iampdS5PHI9XQvQ0EfyUbZhcV2XQObkKFnwYPwH8Ah/H37UAPRnmU8LDYSWpdwm4km
 p3B6P3xtxBS31dQz/n4f+Otx8Fi1Ujihkoo1KHyDENtL2TpE8IMTtDtMId1ZgyAfhPyGqd5zYNh
 4udsBb8JQ133EF5DWCX75sn9ITLOL56rVa8ELuUdYrIPsERvgfCfg1d2rWXq3r59hnD+Wlotevh
 0XkjiTMVCCRDUYX8T/t7IYd+r9NAh7ZzOhRmIU+kFTbZaQUJ2PoQFhGfJoIhXX5Rnsy9UDXrj2K
 B8TTaoZ36xhsuH/WWGuSINDhiDEy/1cZ7R1+r/JMreOYAb24
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Authority-Analysis: v=2.4 cv=YYu95xRf c=1 sm=1 tr=0 ts=685a09e9 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=6IFa9wvqVegA:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8
 a=pEElvNPFZa0bE_926OUA:9 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: gw825jukqLF6gjjLP6TP14MHTkzrjSIh
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjI0MDAxNyBTYWx0ZWRfX6s3PuU+/hmfz
 F+7wBf0+ay8PVQHTLSOPmg+6utaMI988ENXHEOnN7te3YsT09IEsBMlzBRVysiNYOVmumNvT6KN
 46m6bucVdzC8eTICwGOsMvaGXHxV1UIo+5XcBH7oLDiZkzKzh1dyn0LsENsK4BjAVF611gdqjgG
 OeFeqSNG9PrixozLgw/WUDZpKj5SQ9uyH5aGB+xkFpDJku3s5ct8+sqwv+m6yh5yl/RsBb7bSB7
 LcJgUSi85f6jDF14qeH5aHWH6NG0LT2ixcWzmiazpRk4/T3wTX9xaHaeokEnaxT+MQvpIO+i+X3
 yax5YeAlbVpWta6ihgPOux+se8hUrf5p7pv+Jaz4StlRI5nLLNBfNuhfWMfXrCWfdYUCyHYacHw
 QsSyTOdmZ36Kq2NdAJTlr/rXAOe3v6hpLUtGc/Ch9h3aJLmOr/Sw6VV78GDrV7f8fNdrbgVb
X-Proofpoint-ORIG-GUID: gw825jukqLF6gjjLP6TP14MHTkzrjSIh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-24_01,2025-06-23_07,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 spamscore=0 impostorscore=0 suspectscore=0
 lowpriorityscore=0 priorityscore=1501 phishscore=0 mlxlogscore=999
 clxscore=1011 mlxscore=0 bulkscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2506240017

Lenovo Yoga C630 is a WoA / WoS laptop, which uses a "standard" QSEECOM /
uefisecapp application in order to implement UEFI variables. However as
this platform has only one storage (UFS) shared between Linux and
SecureOS world, uefisecapp can not update variables directly. It
requires some additional steps in order to update variables, which are
not yet reverse engineered.

However even with the current driver it is possible to implement R/O
UEFI vars access, which e.g. lets the RTC driver to read RTC offset,
providing Linux with a correct time.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
Changes in v3:
- Picked up patches from another series, reworking the QSEECOM
  allowtable
- Added a fix for efivar_set_variable() crashing the machine if R/O UEFI
  vars are provided (Johan)
- Link to v2: https://lore.kernel.org/r/20250621-more-qseecom-v2-0-6e8f635640c5@oss.qualcomm.com
- Link to the merged series: https://lore.kernel.org/r/20241103-rework-qseecom-v1-0-1d75d4eedc1e@linaro.org/

Changes in v2:
- Added QSEECOM quirks in order to make UEFI vars r/o on C630.
- Added DT patch, specifying the use of UEFI vars for RTC offset.
- Link to v1: https://lore.kernel.org/r/20240725-more-qseecom-v1-1-a55a3553d1fe@linaro.org

---
Dmitry Baryshkov (8):
      efi: efivars: don't crash in efivar_set_variable{,_locked} in r/o case
      firmware: qcom: scm: allow specifying quirks for QSEECOM implementations
      firmware: qcom: uefisecapp: add support for R/O UEFI vars
      firmware: qcom: enable QSEECOM on Lenovo Yoga C630
      firmware; qcom: scm: enable QSEECOM on SC8280XP CRD
      firmware: qcom: scm: add modparam to control QSEECOM enablement
      firmware: qcom: scm: rework QSEECOM allowlist
      arm64: dts: qcom: sdm850-lenovo-yoga-c630: fix RTC offset info

 arch/arm64/boot/dts/qcom/pm8998.dtsi               |  2 +-
 .../boot/dts/qcom/sdm850-lenovo-yoga-c630.dts      |  4 +
 drivers/firmware/efi/vars.c                        |  2 +
 drivers/firmware/qcom/qcom_qseecom.c               |  6 +-
 drivers/firmware/qcom/qcom_qseecom_uefisecapp.c    | 18 +++-
 drivers/firmware/qcom/qcom_scm.c                   | 99 +++++++++++++---------
 include/linux/firmware/qcom/qcom_qseecom.h         |  3 +
 7 files changed, 93 insertions(+), 41 deletions(-)
---
base-commit: 5d4809e25903ab8e74034c1f23c787fd26d52934
change-id: 20240725-more-qseecom-379933b9c769

Best regards,
-- 
With best wishes
Dmitry


