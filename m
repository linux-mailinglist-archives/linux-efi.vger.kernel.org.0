Return-Path: <linux-efi+bounces-1043-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C4D1C8C7B1B
	for <lists+linux-efi@lfdr.de>; Thu, 16 May 2024 19:29:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 79EC8283730
	for <lists+linux-efi@lfdr.de>; Thu, 16 May 2024 17:29:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE9B41553AA;
	Thu, 16 May 2024 17:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=akamai.com header.i=@akamai.com header.b="chHh8eFs"
X-Original-To: linux-efi@vger.kernel.org
Received: from mx0b-00190b01.pphosted.com (mx0b-00190b01.pphosted.com [67.231.157.127])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 980B553392;
	Thu, 16 May 2024 17:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.157.127
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715880561; cv=none; b=Pmw6lSUVLtYL+pZLiSqPOZTrROlp8kO/qGtaKwilx7BK4GBTkSt+ydoZ37JJSBnaQEogNGdUKcAHM0QYU+G08/r0GH3aTxsIOs4FD/Q4RltmErkZoNGe6hzjQ5wCan0DFOySX6s1DH+iXWk6TlA9oJwkUecw7GavoXFcpx/bjgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715880561; c=relaxed/simple;
	bh=QOwBXzs+B/FnJjlHkVIg2c4hvucIpHASSs1js++W2xs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ZDF5Uzy5rKG3KnRAHLRgxKo59EzBoPeFYkIwpDbUMlEOAVG/cii3z+Wzul5lw2b19vAiii3OtskRvvb6nn3ITmn0z8Qai8STHKq4H3kjIwzT7El9PtveVeDrzK5YmDaYi24FqtzehrgaB2LiRvwuDVyXiZM98qc/Se7XVZWthMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=akamai.com; spf=pass smtp.mailfrom=akamai.com; dkim=pass (2048-bit key) header.d=akamai.com header.i=@akamai.com header.b=chHh8eFs; arc=none smtp.client-ip=67.231.157.127
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=akamai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=akamai.com
Received: from pps.filterd (m0050102.ppops.net [127.0.0.1])
	by m0050102.ppops.net-00190b01. (8.18.1.2/8.18.1.2) with ESMTP id 44GEwqF5030147;
	Thu, 16 May 2024 18:29:13 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akamai.com; h=
	from:to:cc:subject:date:message-id:references:in-reply-to
	:content-type:content-id:content-transfer-encoding:mime-version;
	 s=jan2016.eng; bh=QOwBXzs+B/FnJjlHkVIg2c4hvucIpHASSs1js++W2xs=; b=
	chHh8eFsje+fKzhouMS0yRmCJaZj2aE8uuNUu4RdnMl+L2RaPyvOP6S43pYH1T02
	b4r4CvoqJAKSbu+18qB+INpRX1Pl6s7xmpp88vUycvtbLihZyFBRtt6bxPD+tnF3
	Ud1ST2u5tAgCOnzb4WvOLkHCEcmA3ZpJmdnolxVa7dlQv41K6fRSBh6RqnlQ9V9g
	F90cck/jaB1DV584MSnj5ZuNdUCmH4xHO0NJg57p+St0euspgmOqMCSQVmafsa1r
	qJmBi14fjoEOR/38tVgk1uIsPHwWijXsf1fMdjJ8nP9ZHpcP+fvYFNHXjdaYv63J
	3tIjCLElNJIFa4QtlBZm5g==
Received: from prod-mail-ppoint6 (prod-mail-ppoint6.akamai.com [184.51.33.61] (may be forged))
	by m0050102.ppops.net-00190b01. (PPS) with ESMTPS id 3y1ye5ue8n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 16 May 2024 18:29:13 +0100 (BST)
Received: from pps.filterd (prod-mail-ppoint6.akamai.com [127.0.0.1])
	by prod-mail-ppoint6.akamai.com (8.17.1.19/8.17.1.19) with ESMTP id 44GExU2u025709;
	Thu, 16 May 2024 13:29:12 -0400
Received: from email.msg.corp.akamai.com ([172.27.91.22])
	by prod-mail-ppoint6.akamai.com (PPS) with ESMTPS id 3y240y03tk-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 16 May 2024 13:29:12 -0400
Received: from usma1ex-dag4mb1.msg.corp.akamai.com (172.27.91.20) by
 usma1ex-dag4mb3.msg.corp.akamai.com (172.27.91.22) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Thu, 16 May 2024 13:29:12 -0400
Received: from usma1ex-dag4mb1.msg.corp.akamai.com ([172.27.91.20]) by
 usma1ex-dag4mb1.msg.corp.akamai.com ([172.27.91.20]) with mapi id
 15.02.1258.028; Thu, 16 May 2024 13:29:12 -0400
From: "Chaney, Ben" <bchaney@akamai.com>
To: Ard Biesheuvel <ardb+git@google.com>,
        "linux-efi@vger.kernel.org"
	<linux-efi@vger.kernel.org>
CC: "keescook@chromium.org" <keescook@chromium.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>, Ard Biesheuvel <ardb@kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH] x86/efistub: Omit physical KASLR when memory reservations
 exist
Thread-Topic: [PATCH] x86/efistub: Omit physical KASLR when memory
 reservations exist
Thread-Index: AQHap3BEN52kUBFw3k26As6aZLAiM7GaHkCA
Date: Thu, 16 May 2024 17:29:11 +0000
Message-ID: <FBF468D5-18D6-4D29-B6A2-83A0A1998A05@akamai.com>
References: <20240516090541.4164270-2-ardb+git@google.com>
In-Reply-To: <20240516090541.4164270-2-ardb+git@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Content-Type: text/plain; charset="utf-8"
Content-ID: <A284D31F6E507D4EB179E416AB63120D@akamai.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-16_07,2024-05-15_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 adultscore=0 phishscore=0
 mlxscore=0 mlxlogscore=515 suspectscore=0 malwarescore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2405010000
 definitions=main-2405160124
X-Proofpoint-GUID: pHyxdtuvwcqKQ5ShFUaV2oH2LanF-KK9
X-Proofpoint-ORIG-GUID: pHyxdtuvwcqKQ5ShFUaV2oH2LanF-KK9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-16_07,2024-05-15_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 priorityscore=1501
 adultscore=0 spamscore=0 clxscore=1011 bulkscore=0 impostorscore=0
 suspectscore=0 lowpriorityscore=0 mlxscore=0 phishscore=0 mlxlogscore=382
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2405010000
 definitions=main-2405160125

PiArc3RhdGljIGVmaV9zdGF0dXNfdCBwYXJzZV9vcHRpb25zKGNvbnN0IGNoYXIgKmNtZGxpbmUp
DQo+ICt7DQo+ICsgc3RhdGljIGNvbnN0IGNoYXIgb3B0c1tdWzE0XSA9IHsNCj4gKyAibWVtPSIs
ICJtZW1tYXA9IiwgImVmaV9mYWtlX21lbT0iLCAiaHVnZXBhZ2VzPSINCj4gKyB9Ow0KPiArDQoN
CkkgdGhpbmsgd2UgcHJvYmFibHkgd2FudCB0byBpbmNsdWRlIGJvdGggY3Jhc2hrZXJuZWwgYW5k
IHBzdG9yZSBhcyBhcmd1bWVudHMgdGhhdCBjYW4gZGlzYWJsZSB0aGlzIHJhbmRvbWl6YXRpb24u
DQoNClRoYW5rcywNCglCZW4gDQoNCg==

