Return-Path: <linux-efi+bounces-1041-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 065198C7A73
	for <lists+linux-efi@lfdr.de>; Thu, 16 May 2024 18:38:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 746B21F218E0
	for <lists+linux-efi@lfdr.de>; Thu, 16 May 2024 16:38:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DE8B443D;
	Thu, 16 May 2024 16:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=akamai.com header.i=@akamai.com header.b="XpvgEd2D"
X-Original-To: linux-efi@vger.kernel.org
Received: from mx0a-00190b01.pphosted.com (mx0a-00190b01.pphosted.com [67.231.149.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A92034A0C;
	Thu, 16 May 2024 16:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.149.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715877494; cv=none; b=uuHIBKTllxVYWpq22QzOLRxBA8F87IuqqoiC17byzhfehTv5pcJZLkmRa/FLnD86k3V/9OIONaaW2GZsWEMSyUNreoEUyauP2euOuh9e4aJQc6vE/tHm1cFVRJrmE3N50e0hOHamZ17f0oXiVRC7MfRAWmPI1l9uk1dThdr7vak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715877494; c=relaxed/simple;
	bh=PM+Xl9ZB9Zzi3irlGJ5QBcntm6FOPJDgLM5+LPHRhX4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=r8KegRHfEsODEJ3HQ3mdRVpd8MYc9mxlRz06BlcfWmly6JhNClG77aw4NveYGqaunFm3/qGbnr+Z5XkRWlZfqs5M/SF5IdTcoLQODiPZdCAGXPVogixAkYJ4lYM9amjh3uu5iMvQ8AH7cpU0RI6WHal8iL8Elg+AZLYkvD8PCDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=akamai.com; spf=pass smtp.mailfrom=akamai.com; dkim=pass (2048-bit key) header.d=akamai.com header.i=@akamai.com header.b=XpvgEd2D; arc=none smtp.client-ip=67.231.149.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=akamai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=akamai.com
Received: from pps.filterd (m0409409.ppops.net [127.0.0.1])
	by m0409409.ppops.net-00190b01. (8.18.1.2/8.18.1.2) with ESMTP id 44GExHaM031087;
	Thu, 16 May 2024 15:59:40 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akamai.com; h=
	from:to:cc:subject:date:message-id:references:in-reply-to
	:content-type:content-id:content-transfer-encoding:mime-version;
	 s=jan2016.eng; bh=PM+Xl9ZB9Zzi3irlGJ5QBcntm6FOPJDgLM5+LPHRhX4=; b=
	XpvgEd2DykOaPSl22BysRG+VBpR7QFYQmr/Z6lrpccjWoewiuVvOCDmtK4v9KIZi
	6x9BbxzFPh/1a6JJWfAynFjK8VB1UTFlsC9Jlvay1AfV2bmuJ9jiIUfgnXzQI/uV
	p5g/FhhFBUoBiQ7MPJKNqIsnZaX5GlNgDxsIIV6lJcw1Wj9bEPYM8p+bhnTf613D
	9JViWkvN93ttgFD7l5BxZ7oT1dKlHiH3+A6ViuWRbZkp9dq97K3zjd+tIgNhYXns
	2hZzJAjP6H6Ks5hboO5WdfkAgr2olshVm/4ju9uIr/0v5D0gwp3RUe+Xk7qQMark
	Y/BcCAxucFiEvZG04rpGPw==
Received: from prod-mail-ppoint6 (prod-mail-ppoint6.akamai.com [184.51.33.61] (may be forged))
	by m0409409.ppops.net-00190b01. (PPS) with ESMTPS id 3y5m1cr7uq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 16 May 2024 15:59:39 +0100 (BST)
Received: from pps.filterd (prod-mail-ppoint6.akamai.com [127.0.0.1])
	by prod-mail-ppoint6.akamai.com (8.17.1.19/8.17.1.19) with ESMTP id 44GAhZdU025772;
	Thu, 16 May 2024 10:59:38 -0400
Received: from email.msg.corp.akamai.com ([172.27.91.22])
	by prod-mail-ppoint6.akamai.com (PPS) with ESMTPS id 3y240xynv5-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 16 May 2024 10:59:38 -0400
Received: from usma1ex-dag4mb1.msg.corp.akamai.com (172.27.91.20) by
 usma1ex-dag4mb3.msg.corp.akamai.com (172.27.91.22) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Thu, 16 May 2024 10:59:37 -0400
Received: from usma1ex-dag4mb1.msg.corp.akamai.com ([172.27.91.20]) by
 usma1ex-dag4mb1.msg.corp.akamai.com ([172.27.91.20]) with mapi id
 15.02.1258.028; Thu, 16 May 2024 10:59:37 -0400
From: "Chaney, Ben" <bchaney@akamai.com>
To: Kees Cook <kees@kernel.org>, Ard Biesheuvel <ardb@kernel.org>,
        Kees Cook
	<keescook@chromium.org>
CC: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "bp@alien8.de"
	<bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "tglx@linutronix.de"
	<tglx@linutronix.de>,
        "Tottenham, Max" <mtottenh@akamai.com>,
        "Hunt, Joshua"
	<johunt@akamai.com>,
        "Galaxy, Michael" <mgalaxy@akamai.com>
Subject: Re: Regression in 6.1.81: Missing memory in pmem device
Thread-Topic: Regression in 6.1.81: Missing memory in pmem device
Thread-Index: AQHapu3aAXNBspXH5EmfViMgDx95d7GY082AgAANNgCAARR3AA==
Date: Thu, 16 May 2024 14:59:37 +0000
Message-ID: <975461E5-D2BB-40FB-9345-31C4665224A2@akamai.com>
References: <FA5F6719-8824-4B04-803E-82990E65E627@akamai.com>
 <CAMj1kXE2ZvaKout=nSfv08Hn5yvf8SRGhQeTikZcUeQOmyDgnw@mail.gmail.com>
 <742E72A5-4792-4B72-B556-22929BBB1AD9@kernel.org>
In-Reply-To: <742E72A5-4792-4B72-B556-22929BBB1AD9@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Content-Type: text/plain; charset="utf-8"
Content-ID: <BF58598D8264D242978369AA9489FA29@akamai.com>
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
 mlxscore=0 mlxlogscore=999 suspectscore=0 malwarescore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2405010000
 definitions=main-2405160104
X-Proofpoint-ORIG-GUID: ycuVwuJlfuifFGmJtf2JZhpd3lce9rO-
X-Proofpoint-GUID: ycuVwuJlfuifFGmJtf2JZhpd3lce9rO-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-16_07,2024-05-15_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0 bulkscore=0
 lowpriorityscore=0 adultscore=0 spamscore=0 malwarescore=0 phishscore=0
 mlxscore=0 mlxlogscore=946 clxscore=1011 suspectscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2405010000
 definitions=main-2405160105

VGhlICdub2thc2xyJyBmbGFnIGRvZXMgd29yayBhcm91bmQgdGhpcyBpc3N1ZSwgYnV0IHVzaW5n
IGl0IGhhcyBhIGZldyBkb3duc2lkZXMuDQoNCkZpcnN0LCB3ZSB3b3VsZCBsaWtlIHRoZSBzZWN1
cml0eSBiZW5lZml0IHByb3ZpZGVkIGJlIEFTTFIuIEFsc28sIHRoaXMgaW1wb3NlcyBhIHJlc3Ry
aWN0aW9uIG9uIHdoYXQgbWVtbWFwcyBhcmUgcG9zc2libGUuIEl0IHdvdWxkIHRoZW4gYmUgcmVx
dWlyZWQgdG8gaGF2ZSB0aGVtIG9mZnNldCBmcm9tIHRoZSBiZWdpbm5pbmcgb2YgdGhlIG1lbW9y
eS4NCg0KSSBhbHNvIHRoaW5rIHRoZXJlIGFyZSBhIGZldyBvdGhlciBmZWF0dXJlcyB0aGF0IG1h
eSBiZSBpbXBhY3RlZCBieSB0aGlzLCB0aGF0IHdlcmUgbm90IGFkZHJlc3NlZCBieSB0aGUgcGF0
Y2guIGNyYXNoa2VybmVsIGFuZCBwc3RvcmUgYm90aCBwcm9iYWJseSBuZWVkIHBoeXNpY2FsIGth
c2xyIGRpc2FibGVkIGFzIHdlbGwuDQoNClRoYW5rcywNCglCZW4gDQoNCg0K77u/T24gNS8xNS8y
NCwgMjozMCBQTSwgIktlZXMgQ29vayIgPGtlZXNAa2VybmVsLm9yZyA8bWFpbHRvOmtlZXNAa2Vy
bmVsLm9yZz4+IHdyb3RlOg0KDQoNCg0KDQoNCg0KT24gTWF5IDE1LCAyMDI0IDEwOjQyOjQ5IEFN
IFBEVCwgQXJkIEJpZXNoZXV2ZWwgPGFyZGJAa2VybmVsLm9yZyA8bWFpbHRvOmFyZGJAa2VybmVs
Lm9yZz4+IHdyb3RlOg0KPihjYyBLZWVzKQ0KPg0KPk9uIFdlZCwgMTUgTWF5IDIwMjQgYXQgMTk6
MzIsIENoYW5leSwgQmVuIDxiY2hhbmV5QGFrYW1haS5jb20gPG1haWx0bzpiY2hhbmV5QGFrYW1h
aS5jb20+PiB3cm90ZToNCj4+DQo+PiBIZWxsbywNCj4+IEkgZW5jb3VudGVyZWQgYW4gaXNzdWUg
d2hlbiB1cGdyYWRpbmcgdG8gNi4xLjg5IGZyb20gNi4xLjc3LiBUaGlzIHVwZ3JhZGUgY2F1c2Vk
IGEgYnJlYWthZ2UgaW4gZW11bGF0ZWQgcGVyc2lzdGVudCBtZW1vcnkuIFNpZ25pZmljYW50IGFt
b3VudHMgb2YgbWVtb3J5IGFyZSBtaXNzaW5nIGZyb20gYSBwbWVtIGRldmljZToNCj4+DQo+PiBm
ZGlzayAtbCAvZGV2L3BtZW0qDQo+PiBEaXNrIC9kZXYvcG1lbTA6IDM1NS45IEdpQiwgMzgyMTE3
ODcxNjE2IGJ5dGVzLCA3NDYzMjM5Njggc2VjdG9ycw0KPj4gVW5pdHM6IHNlY3RvcnMgb2YgMSAq
IDUxMiA9IDUxMiBieXRlcw0KPj4gU2VjdG9yIHNpemUgKGxvZ2ljYWwvcGh5c2ljYWwpOiA1MTIg
Ynl0ZXMgLyA0MDk2IGJ5dGVzDQo+PiBJL08gc2l6ZSAobWluaW11bS9vcHRpbWFsKTogNDA5NiBi
eXRlcyAvIDQwOTYgYnl0ZXMNCj4+DQo+PiBEaXNrIC9kZXYvcG1lbTE6IDI1LjM4IEdpQiwgMjcy
NDYxOTg3ODQgYnl0ZXMsIDUzMjE1MjMyIHNlY3RvcnMNCj4+IFVuaXRzOiBzZWN0b3JzIG9mIDEg
KiA1MTIgPSA1MTIgYnl0ZXMNCj4+IFNlY3RvciBzaXplIChsb2dpY2FsL3BoeXNpY2FsKTogNTEy
IGJ5dGVzIC8gNDA5NiBieXRlcw0KPj4gSS9PIHNpemUgKG1pbmltdW0vb3B0aW1hbCk6IDQwOTYg
Ynl0ZXMgLyA0MDk2IGJ5dGVzDQo+Pg0KPj4gVGhlIG1lbW1hcCBwYXJhbWV0ZXIgdGhhdCBjcmVh
dGVkIHRoZXNlIHBtZW0gZGV2aWNlcyBpcyDigJxtZW1tYXA9MzY0NDE2TSEyODY3Mk0sMzY3NDg4
TSE0MTk4NDBN4oCdLCB3aGljaCBzaG91bGQgY2F1c2UgYSBtdWNoIGxhcmdlciBhbW91bnQgb2Yg
bWVtb3J5IHRvIGJlIGFsbG9jYXRlZCB0byAvZGV2L3BtZW0xLiBUaGUgYW1vdW50IG9mIG1pc3Np
bmcgbWVtb3J5IGFuZCB0aGUgZGV2aWNlIGl0IGlzIG1pc3NpbmcgZnJvbSBpcyByYW5kb21pemVk
IG9uIGVhY2ggcmVib290LiBUaGVyZSBpcyBzb21lIGFtb3VudCBvZiBtZW1vcnkgbWlzc2luZyBp
biBhbG1vc3QgYWxsIGNhc2VzLCBidXQgbm90IDEwMCUgb2YgdGhlIHRpbWUuIE5vdGFibHksIHRo
ZSBtZW1vcnkgdGhhdCBpcyBtaXNzaW5nIGZyb20gdGhlc2UgZGV2aWNlcyBpcyBub3QgcmVjbGFp
bWVkIGJ5IHRoZSBzeXN0ZW0gZm9yIGdlbmVyYWwgdXNlLiBUaGlzIHN5c3RlbSBpbiBxdWVzdGlv
biBoYXMgNzY4R0Igb2YgbWVtb3J5IHNwbGl0IGV2ZW5seSBhY3Jvc3MgdHdvIE5VTUEgbm9kZXMu
DQo+Pg0KPj4gV2hlbiB0aGUgZXJyb3Igb2NjdXJzLCB0aGVyZSBhcmUgYWxzbyB0aGUgZm9sbG93
aW5nIGVycm9yIG1lc3NhZ2VzIHNob3dpbmcgdXAgaW4gZG1lc2c6DQo+Pg0KPj4gWyA1LjMxODMx
N10gbmRfcG1lbSBuYW1lc3BhY2UxLjA6IFttZW0gMHg1YzIwNDJjMDAwLTB4NWZmN2ZmZmZmZiBm
bGFncyAweDIwMF0gbWlzYWxpZ25lZCwgdW5hYmxlIHRvIG1hcA0KPj4gWyA1LjMzNTA3M10gbmRf
cG1lbTogcHJvYmUgb2YgbmFtZXNwYWNlMS4wIGZhaWxlZCB3aXRoIGVycm9yIC05NQ0KPj4NCj4+
IEJpc2VjdGlvbiBpbXBsaWNhdGVzIDJkZmFlYWMzZjM4ZTRlNTUwZDIxNTIwNGVlZGQ5N2EwNjFm
ZGMxMTggYXMgdGhlIHBhdGNoIHRoYXQgZmlyc3QgY2F1c2VkIHRoZSBpc3N1ZS4gSSBiZWxpZXZl
IHRoZSBjYXVzZSBvZiB0aGUgaXNzdWUgaXMgdGhhdCB0aGUgRUZJIHN0dWIgaXMgcmFuZG9taXpp
bmcgdGhlIGxvY2F0aW9uIG9mIHRoZSBkZWNvbXByZXNzZWQga2VybmVsIHdpdGhvdXQgYWNjb3Vu
dGluZyBmb3IgdGhlIG1lbW9yeSBtYXAsIGFuZCBpdCBpcyBjbG9iYmVyaW5nIHNvbWUgb2YgdGhl
IG1lbW9yeSB0aGF0IGhhcyBiZWVuIHJlc2VydmVkIGZvciBwbWVtLg0KPj4NCj4NCj5Eb2VzIHVz
aW5nICdub2thc2xyJyBvbiB0aGUga2VybmVsIGNvbW1hbmQgbGluZSB3b3JrIGFyb3VuZCB0aGlz
Pw0KPg0KPkkgdGhpbmsgaW4gdGhpcyBwYXJ0aWN1bGFyIGNhc2UsIHdlIGNvdWxkIGp1c3QgZGlz
YWJsZSBwaHlzaWNhbCBLQVNMUg0KPihidXQgcmV0YWluIHZpcnR1YWwgS0FTTFIpIGlmIG1lbW1h
cD0gYXBwZWFycyBvbiB0aGUga2VybmVsIGNvbW1hbmQNCj5saW5lLCBvbiB0aGUgYmFzaXMgdGhh
dCBlbXVsYXRlZCBwZXJzaXN0ZW50IG1lbW9yeSBpcyBzb21ld2hhdCBvZiBhDQo+bmljaGUgdXNl
IGNhc2UsIGFuZCBwaHlzaWNhbCBLQVNMUiBpcyBub3QgYXMgaW1wb3J0YW50IGFzIHZpcnR1YWwN
Cj5LQVNMUiAod2hpY2ggc2hvdWxkbid0IGJlIGltcGxpY2F0ZWQgaW4gdGhpcykuDQoNCg0KWWVh
aCwgdGhhdCBzZWVtcyByZWFzb25hYmxlIHRvIG1lLiBBcyBsb25nIGFzIHdlIHB1dCBhIG5vdGlj
ZSB0byBkbWVzZyB0aGF0IHBoeXNpY2FsIEFTTFIgd2FzIGRpc2FibGVkIGR1ZSB0byBtZW1tYXAn
cyBwaHlzaWNhbCByZXNlcnZhdGlvbi4gSWYgdGhpcyB1c2FnZSBiZWNvbWVzIG1vcmUgY29tbW9u
LCB3ZSBzaG91bGQgZmluZCBhIGJldHRlciB3YXksIHRob3VnaC4gDQoNCg0KVGhpcyByZW1pbmRz
IG1lIGEgYml0IG9mIHRoZSB3b3JrIFN0ZXZlIGhhcyBiZWVuIGV4cGxvcmluZzoNCmh0dHBzOi8v
dXJsZGVmZW5zZS5jb20vdjMvX19odHRwczovL2xvcmUua2VybmVsLm9yZy9hbGwvMjAyNDA1MDkx
NjMzMTAuMmFhMGIyZTFAcm9yc2NoYWNoLmxvY2FsLmhvbWUgPG1haWx0bzoyMDI0MDUwOTE2MzMx
MC4yYWEwYjJlMUByb3JzY2hhY2gubG9jYWwuaG9tZT4vX187ISFHanZUel92ayFXc0VOQTh3M1Bh
WUVHcHBTa0VZU3BlbEMtQ0gySlIzNVNBVEpYcmo4bUhpeEZHM1NDX2FqX0lpMHlTYm1HaFFnOFYx
U1Y0c3N6a1kkIA0KDQoNCg0KDQoNCg0KLS0gDQpLZWVzIENvb2sNCg0KDQoNCg==

