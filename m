Return-Path: <linux-efi+bounces-924-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A0628899DC1
	for <lists+linux-efi@lfdr.de>; Fri,  5 Apr 2024 14:58:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 554072842B1
	for <lists+linux-efi@lfdr.de>; Fri,  5 Apr 2024 12:58:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2413216D334;
	Fri,  5 Apr 2024 12:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="CuScxH63";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="lIt/rXpx"
X-Original-To: linux-efi@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE30D16D330;
	Fri,  5 Apr 2024 12:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712321844; cv=fail; b=XK7P78tkV0pfVKwfW9ehwFZqv4Ufk9U8nzd4EQo+TTiFl0P/C0YfjcUwZgM9NAQLgv+kWvcSbpYyYpgnA7SuMyalhV5mLc+GpOu6W5FliR5uVEv7IChTjIYS/vNC+d37eDJyVmP2vtEmi1cmhxXfR6GseeuijPH5RHV8KB4mmtU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712321844; c=relaxed/simple;
	bh=FU/BnchMuASO+z5u8yA6s6J/rqihDaE9RBbR2yi1DKg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=IglAZdD76rAs6z6f1JM0WKkg4dv5+whabDiElJj1tHXi7xoLj7ADlw2GXtZvF6Qiu9OFppep9EGaVHtj1BrDmjAbZc/uefaPlB4c8F9gHIGLi6VrG/oZXl9EyLpnBsL8PTC9LEh53jnmvG7lczpZqzWa/qbooGBSDik9hUN9wcg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=CuScxH63; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=lIt/rXpx; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 4358Y0HT020026;
	Fri, 5 Apr 2024 12:56:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=FU/BnchMuASO+z5u8yA6s6J/rqihDaE9RBbR2yi1DKg=;
 b=CuScxH635eOORKcAR0yWh8IJRzKUBHBf9qW/VO8au1PFMKbxthR3GpQJ6AKFx+5mJskO
 xRBt8wBCKxpD1zC7J9mFYJD//8Inlg6EzlW5F3tVIVbzchYyBH3vV88MQXvAWw1aIRa5
 83o4L4/y8M9bVIzXMvTeLC+9A+gSi4ohW26/hmTQyjT+J7CKnv2EjuH7uenPc7JZs8WU
 hSIYbHerkvH+/L9PaEEPLS9ldma2hdbIrtCkw9yasREhv5jP0b1WlhYi4yOugXcwJZve
 IQ3wvKCr3qPcHUeNBFjXcQqC3+CK4qCLKUjYV25o7cGA10K3nkBzg0iY+F6o5tvkuWr/ fg== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3x9emvuf6g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 05 Apr 2024 12:56:41 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 435CHIWJ039255;
	Fri, 5 Apr 2024 12:56:41 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2101.outbound.protection.outlook.com [104.47.55.101])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3x9emsjm7b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 05 Apr 2024 12:56:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iKEFi+24JA3iPpjbhDSbXHDUo8VguokEVYuHjyQNRlhxv5n1u79L2W3RFjdonbpEhfUF2B2owl1pIVjgUZ0iHWY6QPtKVzgmaRABjo5sFaBlyuGoK1K5XDWagO7/TlZyoSivKp1O8bGHjvTSHcBbccy4Hr52jIz5uB06DMw3MtCL0QvXob2KQ9MmSxKMhEIYp+t+N5Ecli4vc3F/AEv2xC14w6BdSUnKzoKQzUqkpr+fKseuN9demrnb79WoBRhN0h5wAKhOyjetQ1GttQiI1KGio59QTc3IohDqFmJd+bHKsrWUI0ADj/VflCR21/fDKhnl1A/qMZwLkZA2LTONUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FU/BnchMuASO+z5u8yA6s6J/rqihDaE9RBbR2yi1DKg=;
 b=Z4AEJyjNiOdmf0mwld+3b9ECDjpJXziRS/zz7wCosQ2IvMq/4S6gX69dygSHcLwRl0LyVnatQaQHQ3KLmET6ECBuj0wfU/8EY9I7qU4yDyEDaqTIIJ8oALjEAkM0DnaeQ41Wd5QG/929qcEx//orocXO3f9aASA8fkJ1m2jB2aNQQ1DtiPutcfPXAIGKNS08wNBgWmgwCJhrtqxlXXyLBAsH9PDeKtgRhUCgcpn0Mvs+3aNBK3S9QQlbgcB2lMoe5Z7XJaGrkWfeLoQrYBw+TDsoUv/yXKa4MUa/78KNzB9Omj8LDVSo3yxUjI9Pvtj4s0HM4LfvXCjV52cQceQogA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FU/BnchMuASO+z5u8yA6s6J/rqihDaE9RBbR2yi1DKg=;
 b=lIt/rXpxFf/7/l7K3uCfa75gA5aK/Wv10Z57Wj3ieU8xcs02+ENVeCmQg3hBs6747PdVEFzuES7xDHivQcUCRyk+tIL8VYUPKy3nZoBye4glS6xp/MsohTJ2er/QKPrNCVL3r8CbgCqa4aXsYpWiw0G9pqEUi9a49pvoOvI83Vw=
Received: from CH2PR10MB4150.namprd10.prod.outlook.com (2603:10b6:610:ac::13)
 by DS0PR10MB6751.namprd10.prod.outlook.com (2603:10b6:8:136::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Fri, 5 Apr
 2024 12:56:37 +0000
Received: from CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::6db5:3501:4d88:1532]) by CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::6db5:3501:4d88:1532%3]) with mapi id 15.20.7409.042; Fri, 5 Apr 2024
 12:56:37 +0000
From: Eric Snowberg <eric.snowberg@oracle.com>
To: Mimi Zohar <zohar@linux.ibm.com>
CC: "open list:SECURITY SUBSYSTEM" <linux-security-module@vger.kernel.org>,
        David Howells <dhowells@redhat.com>,
        David Woodhouse <dwmw2@infradead.org>,
        "herbert@gondor.apana.org.au" <herbert@gondor.apana.org.au>,
        "davem@davemloft.net" <davem@davemloft.net>,
        Ard Biesheuvel
	<ardb@kernel.org>, Jarkko Sakkinen <jarkko@kernel.org>,
        Paul Moore
	<paul@paul-moore.com>, James Morris <jmorris@namei.org>,
        "Serge E. Hallyn"
	<serge@hallyn.com>,
        Roberto Sassu <roberto.sassu@huawei.com>,
        Dmitry Kasatkin
	<dmitry.kasatkin@gmail.com>,
        =?utf-8?B?TWlja2HDq2wgU2FsYcO8bg==?=
	<mic@digikod.net>,
        "casey@schaufler-ca.com" <casey@schaufler-ca.com>,
        Stefan
 Berger <stefanb@linux.ibm.com>,
        open list <linux-kernel@vger.kernel.org>,
        "keyrings@vger.kernel.org" <keyrings@vger.kernel.org>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>
Subject: Re: [PATCH RFC 1/8] certs: Introduce ability to link to a system key
Thread-Topic: [PATCH RFC 1/8] certs: Introduce ability to link to a system key
Thread-Index: AQHac8/Wy3kR1DBbWUSwLVt/DZ3pl7FY2n4AgADvOYA=
Date: Fri, 5 Apr 2024 12:56:37 +0000
Message-ID: <3F255143-C9FE-426E-AD6B-4B4EF7709ED5@oracle.com>
References: <20240311161111.3268190-1-eric.snowberg@oracle.com>
 <20240311161111.3268190-2-eric.snowberg@oracle.com>
 <c3267eef03fd3e8bffe77c86debd9353627108c1.camel@linux.ibm.com>
In-Reply-To: <c3267eef03fd3e8bffe77c86debd9353627108c1.camel@linux.ibm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3774.500.171.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH2PR10MB4150:EE_|DS0PR10MB6751:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 R8FZMWs5yS+HPrj3W90TEgPUBbIIP+txj8MnQpCjBlm+b8PUs++hKriYQ2aTGLEaytjnWGKety5DEqSApVdKsiPOsPFyvTTqkkDDbBqgyIasFVCs8ZNjEYyibLhuIBeZ64a/MpMCRMJLHlFsBo33dQjUJ5OHyp8yAkaxX/gkMUzLGCoMLnQJJt2CnZQFU7nAKzVCs+5JQMLNhk2oPW3foEddcPpDEzR2N0OJhUUmI+FLO/dq83ump5BbQr+bFQR/bHuySNUR9R8dOIf9if9g3tvo1foUy3lxLj5KbDp1WUJTO6GY8RTkyltAQUYWTbV6BxSHltW60ZDP8fmjYMeevsogSMTsdDpijA5bQ5HxoFQdrsOAuxirD6ZW/WRlKxUoFFoGkSYIEUuKLBEp9csca1zyMEfK12pjT6/zgVdLP42Q4ToHu3AMrvtbuYDb5wKIRCf/HThngz97fE+B78gNoFLdJAXjhyzihHgLafCS/GXgONNaF8w6+dUQhPudl+lvW+DmQ5S2HwzwEqpRmnMKzc9Gbu+VqDsMQXqY+ejL7NPehDPz10gSA30L4WiK0+N3xmj7td9jOaNRZgrR/w+tuFV/2cp26+1wkyMyUKin53TPDEpD3YjC3makNhmz7NR/Dt5Aks9DwDgS9GN9EGmFk9i78hQr9XCkSF406yRjzu4=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4150.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(7416005)(376005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?Y1BEWGdTcHNhV1Q0ZDc0clZ6VGhyNGIvVUl3S3RtRjdLdzFHZzVoQmF1NEdH?=
 =?utf-8?B?d2JIY1NlamV2eEx0anZwUjY5aHp1eGxsT3hZOFQwd0JVWkMzeXRlQTdaMUFZ?=
 =?utf-8?B?WVN4SkhvR0VDTWJKRG5NTW5tRUtQbE5NdzdRS0dtaEFSRWV2Q2lJNXROVGtC?=
 =?utf-8?B?ZFpkSVBnZS96ZFNQdFQzTUh0OCswQ2dQRDNzYWlpbUwxdG40M3Z2aDNXS1F4?=
 =?utf-8?B?QW0xdm1KcWZVU3FOQko2WHpvNVZ6ZUF2Qk5DTkpDdVlNRVBRTjJuS091c0Qv?=
 =?utf-8?B?R3QrRkNnWXVpdU1paGpXdkdEd3NmSm1JQWF0V05hK2dzOFhSRXJjekFac09r?=
 =?utf-8?B?SjV3QXNRaGdSQzRNaUQvQjI4VHdWSHpVNENmSDBteGZ3OG9jT3pxOUwzSDJj?=
 =?utf-8?B?T3RsWnQyM3l6TC92cUx0bVg4UmpXeWF0MWJrZTBpSmZpVVIwMFNBZGMzU3h3?=
 =?utf-8?B?dzdFN1ZTaUR2T2tpbWRGdHZyMEtvZkROUWIzY2lTbUFqdUZ3VnJsYzN6ZTJX?=
 =?utf-8?B?bitJeG90VXRuMGNLa3VqM0xidkR5ZzhsWW5kQUcrNWlmMU5HYVhFWG8vOFEz?=
 =?utf-8?B?WHVQTWVzVDdNcDFKOUxWOFBNaGdteW1QOVVxMWF0Rnc3SFczeGF4YkpBSXV2?=
 =?utf-8?B?cDZ5NlF1QkpIbE9OM0V1WEpvMjVIOHZBVCt1K1JnQUdDZ3BqelVrTlJQVEd3?=
 =?utf-8?B?MlluVnJMMkgrNHdXYy9oR2xRVjlEbFBoWmEyVjB0Y1RZWGxFNUVlRXZPRDY0?=
 =?utf-8?B?THNiK1R4c0VFZWNmaUVjdExuWFhWQk5WT1AwT0Y2K2lqem54MGRldHcvbzdz?=
 =?utf-8?B?WitCbEJJb1ljd3VEM3Vwa2QwL3F0dlYxMzNjcGpvNko4NjBZTjhieFl1RDZV?=
 =?utf-8?B?UEpIZGcwLzhTdzJsb215RmFtd1F1RENScXZXM3I4TDBiWFArbFNHR1U5Z0dt?=
 =?utf-8?B?MHM3ZTh1a0Zyb01Nck92bGUyOEU2dDhtQ2p6ZHRZSFpTaWlhYkFCRXRhTHp2?=
 =?utf-8?B?dHpuaHZxZmpabElUVjVVcHlPbHJNM0cvcHhDTm5ROW1za0pDSnlDdk1EcnNj?=
 =?utf-8?B?UE5pTmpjZ0lIODRRU2NNR2lQUUNXS25OTXpqVE5FTjh3anlYV2pKSU04VTVi?=
 =?utf-8?B?QjVsR2o0d0RjWXJuN1o4QnQ3MS9Rci8zaTJONGRkRnZ1eUl2c240UXB3aHFD?=
 =?utf-8?B?Q1NCb1IzMy9hdXc5YlZvUHlHTWRzQ25SZ3krQURLRE5rSUN4L3NhMWRVRSti?=
 =?utf-8?B?Z1ErUFJzWGwzZkpsMjJadkJ2Z3RPZFdSQ3BwcitrVzAvTUNZbEcrRHZTWEJP?=
 =?utf-8?B?b3prcnI2RVkzU2ZqK0dUSENxRXJnV1Vub2RRbnFvalRLY1NkbUYxYWVBeHc2?=
 =?utf-8?B?ajI4cms4eHE4MC9tMHE5OFU4elZYRGJ2a0hyZ2ZESGJWMjVYeGJVSmdnMXpN?=
 =?utf-8?B?NEVKODFvS2lQWUxNWFNjVzJqNnpuQXRuMTdOR3FHVDNnZzN5RkFWRStpcFY3?=
 =?utf-8?B?K0JQMjdkaEFMRXQwWXdMN1VocjdWVXI1ZWNQUjdkYW1EMjlURGZxeTFHOEtC?=
 =?utf-8?B?WUVLZzdodmdBU0xQL1NrMHFGQi81N1ErUlFRNndUakgxZ1hPTVpmb09sNTYv?=
 =?utf-8?B?V3N2MCtPQXAySGQ0d0w5bFJ0ZC90ZERyV0xCMWR0UVM2SVc1MTJHb0dZR0JZ?=
 =?utf-8?B?Yk1IR0RqdFluREdqbFJRZmZtSzJlZ2lEMmRkZTVkZUtFakFUMVZyUThZSG15?=
 =?utf-8?B?aGxzUGlYWU9XVkVwempsQVA0YjNoNjZyNlN2RlljWmgrelJMekp6Mnp1UDRj?=
 =?utf-8?B?OXRjVUhqV1IyNTZDT3pTaEtad25yL2pEYnBkOXpwUmhRU3NTTnRmQjM5dmY2?=
 =?utf-8?B?YkRMaHJTRlB5SXRwREhBbHRsM0JDQ3Y1VWdlQkFJTnpDY1hxNlZBcFBOS1g3?=
 =?utf-8?B?ZHc4TEFSNXRTWitIMTFYL1BJb05VcjAwSVJweHV6UnhOemQzRVk0WUFxZnpD?=
 =?utf-8?B?ZmZEM01RNTJseWthLzNWb1lEcTdJdVVkYkN2cWlYVmkrRjVVdmFVT0ZKSHdQ?=
 =?utf-8?B?aU1aczd1dVduOHJUeVZ3cENHamhUTUtSVWRoNFV1YVJxVThuUDdBcVdOVzI4?=
 =?utf-8?B?VkJPaXgraW01N2NWeDJmNG0zRWdMaVh5bFY3NVlrM2YxVE5QVXRrU1ZyNFJ4?=
 =?utf-8?B?bHc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B91E732E93E24941811A1E9D65DD61AC@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	53HPwlfEJW+8M7Uct/IZVK/TSEu1I57tZF3Bv/1bELksUIhkJTA+eNsaLTDCHPYHsKleJarEz4UMTPF4oZjYmaPdSxjBIIOuqqsctOYzoOambTzMVkC1JA7+ls5H55VbmXUpXe3mzN5rxG04IlFOcIM0ievEynK0nxmGZ9OpBvrYjPa9DEf0+qKTQEKhJEZKH2jF1MalT9NosDp/Z+T0YUV09Z8zadtBt933klvcwRTjup1ghJ5bkuilzdcP81V6lIkEUPAYTJu7pe4Ss2LjLoTuy6APJijd708irlhM80uEuV34+zI4100I6vXR/DyAl5v83ApfBNPDioypzFOWHUkNR85vhH8kDT8kKaZMd9SuNwdUdyGzGMU5ZNmhSYlsVKesrrbmwqS09CJcGNIraf8gBbKIuLbdwRTCqtTJTrvo7zLJ8V0T7kK3M22lUW3/SCGF1jJnMwD9cWX9qTXQsREMbMifwhvMeCpAGJdhQfUEYmB60bQKveTNviaqR0+gous39UNqgmSH4N7SrpTuYj/nVaoO64XjyyrP8njRdOthfA746wfnznodiv0sGSoOyz0Ok9iVFkWk9Ep3csFd5Ky14oCbdRWI0RQM/v6Isng=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4150.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d7ac4d4-387d-43f5-b946-08dc556fd48c
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Apr 2024 12:56:37.5322
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: c+eQmMh/qm59LFl5bBYp+FcgAM3rKySoofVkQfLaO6nOEcwuxpKaD4p4XAZC6EmQT9QuI3CvncKmBLy1+rB6pgqBS5+Lk18YN1edsU+lIZ4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6751
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-05_10,2024-04-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 spamscore=0
 suspectscore=0 malwarescore=0 phishscore=0 bulkscore=0 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2404050093
X-Proofpoint-GUID: fNWCtzfyO2oUjIuAYP7Y-12V3yZiihty
X-Proofpoint-ORIG-GUID: fNWCtzfyO2oUjIuAYP7Y-12V3yZiihty

DQoNCj4gT24gQXByIDQsIDIwMjQsIGF0IDQ6NDDigK9QTSwgTWltaSBab2hhciA8em9oYXJAbGlu
dXguaWJtLmNvbT4gd3JvdGU6DQo+IA0KPiBIaSBFcmljLA0KPiANCj4+IGRpZmYgLS1naXQgYS9j
ZXJ0cy9zeXN0ZW1fa2V5cmluZy5jIGIvY2VydHMvc3lzdGVtX2tleXJpbmcuYw0KPj4gaW5kZXgg
OWRlNjEwYmYxZjRiLi5iNjQ3YmU0OWY2ZTAgMTAwNjQ0DQo+PiAtLS0gYS9jZXJ0cy9zeXN0ZW1f
a2V5cmluZy5jDQo+PiArKysgYi9jZXJ0cy9zeXN0ZW1fa2V5cmluZy5jDQo+PiBAQCAtNDI2LDMg
KzQyNiwzMiBAQCB2b2lkIF9faW5pdCBzZXRfcGxhdGZvcm1fdHJ1c3RlZF9rZXlzKHN0cnVjdCBr
ZXkNCj4+ICprZXlyaW5nKQ0KPj4gcGxhdGZvcm1fdHJ1c3RlZF9rZXlzID0ga2V5cmluZzsNCj4+
IH0NCj4+ICNlbmRpZg0KPj4gKw0KPj4gKy8qKg0KPj4gKyAqIHN5c3RlbV9rZXlfbGluayAtIExp
bmsgdG8gYSBzeXN0ZW0ga2V5DQo+PiArICogQGtleXJpbmc6IFRoZSBrZXlyaW5nIHRvIGxpbmsg
aW50bw0KPj4gKyAqIEBpZDogVGhlIGFzeW1tZXRyaWMga2V5IGlkIHRvIGxvb2sgZm9yIGluIHRo
ZSBzeXN0ZW0ga2V5cmluZw0KPj4gKyAqLw0KPj4gK2ludCBzeXN0ZW1fa2V5X2xpbmsoc3RydWN0
IGtleSAqa2V5cmluZywgc3RydWN0IGFzeW1tZXRyaWNfa2V5X2lkICppZCkNCj4+ICt7DQo+PiAr
IHN0cnVjdCBrZXkgKnRrZXk7DQo+PiArDQo+PiArI2lmZGVmIENPTkZJR19TRUNPTkRBUllfVFJV
U1RFRF9LRVlSSU5HDQo+PiArIHRrZXkgPSBmaW5kX2FzeW1tZXRyaWNfa2V5KHNlY29uZGFyeV90
cnVzdGVkX2tleXMsIGlkLCBOVUxMLCBOVUxMLA0KPj4gZmFsc2UpOw0KPj4gKyNlbHNlDQo+PiAr
IHRrZXkgPSBmaW5kX2FzeW1tZXRyaWNfa2V5KGJ1aWx0aW5fdHJ1c3RlZF9rZXlzLCBpZCwgTlVM
TCwgTlVMTCwgZmFsc2UpOw0KPj4gKyNlbmRpZg0KPj4gKyBpZiAoIUlTX0VSUih0a2V5KSkNCj4+
ICsgZ290byBmb3VuZDsNCj4+ICsNCj4+ICsgdGtleSA9IGZpbmRfYXN5bW1ldHJpY19rZXkocGxh
dGZvcm1fdHJ1c3RlZF9rZXlzLCBpZCwgTlVMTCwgTlVMTCwNCj4+IGZhbHNlKTsNCj4+ICsNCj4+
ICsgaWYgKCFJU19FUlIodGtleSkpDQo+PiArIGdvdG8gZm91bmQ7DQo+PiArDQo+PiArIHJldHVy
biAtMTsNCj4gDQo+IE5vcm1hbGx5ICJnb3RvIiBpcyBmb3IgdGhlIGVycm9yLiAgSW52ZXJ0IHRo
ZSBsb2dpYy4gDQoNCk9rLCBJJ2xsIGNoYW5nZSB0aGF0IGluIHRoZSBuZXh0IHZlcnNpb24uICBU
aGFua3MuDQoNCg==

