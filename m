Return-Path: <linux-efi+bounces-2899-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA58BA50D77
	for <lists+linux-efi@lfdr.de>; Wed,  5 Mar 2025 22:30:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D5ED3AF055
	for <lists+linux-efi@lfdr.de>; Wed,  5 Mar 2025 21:30:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 962FF1FBE85;
	Wed,  5 Mar 2025 21:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="SAjz8sim";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="x9RkIw+H"
X-Original-To: linux-efi@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A82B39FD9;
	Wed,  5 Mar 2025 21:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741210230; cv=fail; b=CsyYHGTDkkCTbGfQGgDUlceAs72DkuPG6Fw8EZziWMY4F/vBsGjs7LvHb9bTGzQo/g/H57jerqeLx0FbfSFH6lc7MAupjzlxqoa1AJR3dWJrD+nUKvjlljRdafo8NBj4iUgI+X23sIodWq8p8G6mmmWULEp+E8C05pCyMIijETE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741210230; c=relaxed/simple;
	bh=zGnj21mCuDsxDeh+whJJRUc5DaBAyggfD6TkXumnmdI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=mUoEXF4eVWlKjv6sw84on82x3OQGsqv+8qwElRA3QAclbOpX77wkMTtWT6zeMin1ct+XSYJeHkBE/OOjL8YqOWKh9DgAm4l+oNVETEJRmhlvrC8LxpeJiQWR3MNbtjnhEZc8yzTfY4vJqob1XefgeWZb1Od54quJKVOKyY5g7Co=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=SAjz8sim; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=x9RkIw+H; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 525LC7Ca014875;
	Wed, 5 Mar 2025 21:29:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=zGnj21mCuDsxDeh+whJJRUc5DaBAyggfD6TkXumnmdI=; b=
	SAjz8simc4Zn/8CvjqS2SHcuFU7V318ljD1SVaU5mzphKSUGfzQbpXh1w/Aq5hX8
	qX7sENiQpPRPcbZmMNL0e9LxEhUNnOQHVz71g0+Zj5K8KRyuxJBZV4wOW5OqkjQm
	B42jxQobu3QXp01L2mX1h8UCapkqSEO1IK7pB/teCdlQeMemfEMBkg8fBo/5NxDU
	LHhIqKdYlPgt2pUezNCtYvccvVMjpEeTAjVearORUWh+/l/FryNMUMO69zqKP5Cv
	Kx4389oq40TchNDkFnGzmfczna0ZExgjP8+sSsNnYbQEmofB6yDcAHKV5Bt8a2Dw
	/MAIDyAtl9X/7VF1S5bT5w==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4541r48mta-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 05 Mar 2025 21:29:47 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 525Ko3fi039821;
	Wed, 5 Mar 2025 21:29:46 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2043.outbound.protection.outlook.com [104.47.56.43])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 453rpbq67j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 05 Mar 2025 21:29:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JZx74HsbyGZ2udle6hbt7GutdjoChnkNAkqxGdr3zvI5FpbbwdVptaxBuMIAX3lqDXIYHZg+NsdyCYc/AqDyITQECCQ2ya6E390z7Rog9MmHV738aU91VMcqR6FoFdk/28y321UjiNiiWCBQnBV8pZbRj0AO6W3+Tj4E5yKxOZWgSacQ9VMwrMTVdzwcIBncFqCm9nhR5aJoctrp/1sJszECpFjzrCoGZA3gf8yimiySAWYB7b/aljxf7PKt0kf2PSpUoGl1C60ybk6cZmp2HueieoH13pygl6xVtJ4V/ifkw0Ac+jgQ8ckKd6NXYiEqwPuTAkcCV9y6QubFq3DSPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zGnj21mCuDsxDeh+whJJRUc5DaBAyggfD6TkXumnmdI=;
 b=acqeiTxMW8jtzhZyP045RYkqYHsvROhRrTnmfIGt+cTokHEgxfikhCBX4wG2YGEjNEfgCGmDbJ1rB53mutPrvcGdlgnZ3Uyv7FKY9Jy2unY0zasCUifF/fZmX+tHK6SG8R7/Ymx8DZsnKjmPaeIfz/a4CYMFqEx9MHQn5IRMe4l1uUMveu8Hr7v1G/ch0Wik2dQx2TEu/nhpKWbQCDQCXze9ImYief+9NU50QTvXWfUUXwQTE3gFsL+/4CGBawfCMJeBea1+XEuDtBAmIWr2ReUE0j8Xn4cIFSWplZLNuyUYdcdQAMuc+9RZ8zDn0bkdDt/iKzLjz/8i3tFjybnEhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zGnj21mCuDsxDeh+whJJRUc5DaBAyggfD6TkXumnmdI=;
 b=x9RkIw+HdH6IkCPOVUjSliW2lW3e5aZGQh7+eV0oFzOhn+JRNnKsVoxYYuXRlU8sR+qkZjnNpcx8YScYt90k9MGplrMzJQQGcyU/XDkTmrfYixa1a79HyGHAFZaIfLWEPMvZfGyPmhlIPCCZb1y/7w7zlx1fYT06YI5IgtHVojI=
Received: from PH7PR10MB7730.namprd10.prod.outlook.com (2603:10b6:510:308::13)
 by SJ0PR10MB4605.namprd10.prod.outlook.com (2603:10b6:a03:2d9::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.17; Wed, 5 Mar
 2025 21:29:44 +0000
Received: from PH7PR10MB7730.namprd10.prod.outlook.com
 ([fe80::7ac6:2653:966f:9411]) by PH7PR10MB7730.namprd10.prod.outlook.com
 ([fe80::7ac6:2653:966f:9411%5]) with mapi id 15.20.8489.025; Wed, 5 Mar 2025
 21:29:44 +0000
From: Eric Snowberg <eric.snowberg@oracle.com>
To: Paul Moore <paul@paul-moore.com>
CC: Mimi Zohar <zohar@linux.ibm.com>, David Howells <dhowells@redhat.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        "open list:SECURITY SUBSYSTEM"
	<linux-security-module@vger.kernel.org>,
        David Woodhouse
	<dwmw2@infradead.org>,
        "herbert@gondor.apana.org.au"
	<herbert@gondor.apana.org.au>,
        "davem@davemloft.net" <davem@davemloft.net>,
        Ard Biesheuvel <ardb@kernel.org>, James Morris <jmorris@namei.org>,
        "Serge E.
 Hallyn" <serge@hallyn.com>,
        Roberto Sassu <roberto.sassu@huawei.com>,
        Dmitry
 Kasatkin <dmitry.kasatkin@gmail.com>,
        =?utf-8?B?TWlja2HDq2wgU2FsYcO8bg==?=
	<mic@digikod.net>,
        "casey@schaufler-ca.com" <casey@schaufler-ca.com>,
        Stefan
 Berger <stefanb@linux.ibm.com>,
        "ebiggers@kernel.org" <ebiggers@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        open list
	<linux-kernel@vger.kernel.org>,
        "keyrings@vger.kernel.org"
	<keyrings@vger.kernel.org>,
        "linux-crypto@vger.kernel.org"
	<linux-crypto@vger.kernel.org>,
        "linux-efi@vger.kernel.org"
	<linux-efi@vger.kernel.org>,
        "linux-integrity@vger.kernel.org"
	<linux-integrity@vger.kernel.org>
Subject: Re: [RFC PATCH v3 00/13] Clavis LSM
Thread-Topic: [RFC PATCH v3 00/13] Clavis LSM
Thread-Index:
 AQHbIK0E/vdc4Eou30K4SgPRfeDFerL0Jc4AgBIDLwCAAF1+gIADEbkAgADjnYCAUfK8AIAAHD0AgAEIXICAACNLAIAAGwsAgAUHzgCAAQ2/gIAAoSGAgAFh24A=
Date: Wed, 5 Mar 2025 21:29:44 +0000
Message-ID: <1A222B45-FCC4-4BBD-8E17-D92697FE467D@oracle.com>
References: <20241017155516.2582369-1-eric.snowberg@oracle.com>
 <c490397315c2704e9ef65c8ad3fefedb239f1997.camel@linux.ibm.com>
 <72F52F71-C7F3-402D-8441-3D636A093FE8@oracle.com>
 <CAHC9VhRHEw5c+drC=aX4xTqWoQJJZ+qkJ7aHUT5dcu+Q5f7BqA@mail.gmail.com>
 <CAHC9VhSJpnaAK1efgs1Uk0Tr3CaDNR1LiDU-t_yDKDQG6J-74Q@mail.gmail.com>
 <E20C617B-EA01-4E69-B5E2-31E9AAD6F7A2@oracle.com>
 <506e8e58e5236a4525b18d84bafa9aae80b24452.camel@linux.ibm.com>
 <CAHC9VhTsZntLdGBV7=4suauS+rzSQv1O4UAoGcy2vEB02wRkoA@mail.gmail.com>
 <c580811716f550ed5d6777db5e143afe4ad06edc.camel@linux.ibm.com>
 <CAHC9VhTz6U5rRdbJBWq0_U4BSKTsiGCsaX=LTgisNNoZXZokOA@mail.gmail.com>
 <FD501FB8-72D2-4B10-A03A-F52FC5B67646@oracle.com>
 <CAHC9VhR961uTFueovLXXaOf-3ZAnvQCWOTfw-wCRuAKOKPAOKw@mail.gmail.com>
 <73B78CE7-1BB8-4065-9EBA-FB69E327725E@oracle.com>
 <CAHC9VhRMUkzLVT5GT5c5hgpfaaKubzcPOTWFDpOmhNne0sswPA@mail.gmail.com>
In-Reply-To:
 <CAHC9VhRMUkzLVT5GT5c5hgpfaaKubzcPOTWFDpOmhNne0sswPA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3776.700.51.11.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR10MB7730:EE_|SJ0PR10MB4605:EE_
x-ms-office365-filtering-correlation-id: 65fe5641-2fbb-4706-2622-08dd5c2cd8d3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|7416014|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?WGhPKzBjSm5kaG1oclI2VzhhZWVWclJzOEQ3Y2YyK2RkanJiVDMzNnBnN09N?=
 =?utf-8?B?bFlTekNMYTVaZnZOOW55Szd6MmxwRWJvaWR2N2dVRE5Pb0NBZ29iYjBvbERN?=
 =?utf-8?B?S2JWeVFHNmdBamRTNWJmUEVNL1NVbitCZmkrb2h3cFhnMXdRRHR6ZUMraGNo?=
 =?utf-8?B?YkhJMUQ0NWdaSUErQTFQSm1SL3ZyYndhaHpDcUFmMlZ0ZkI1KzNGbzFibWRa?=
 =?utf-8?B?aG5sZnFmYVl1NXl6U0tnVE4wdWFhRHk0d2Y5aUgxWXQrZXd4SUs4NWhqV3dB?=
 =?utf-8?B?UEhZc2N6M1poZjlyRlg0V0oxeDdENlFndlByN1pMS1VocFIwaDhBNWptWnh4?=
 =?utf-8?B?MU5yYkVwa0Q1RHZWWWJWNkZMR1BRU2RDcHBzN1FwQkZsMldDekgra0psMk9h?=
 =?utf-8?B?eDZZNHlBemZiZGU5Y00wZEdvVHZWTHBDYmtuOEdyalJzVDJOZW9PQzhmVEVU?=
 =?utf-8?B?TzB0NVpVMmRuWjRwSkpKOVh4VlBjcWJwNXJOZjhyb2JDeU14RUswekthQVB4?=
 =?utf-8?B?bVZ1Wi9zRG9VV1BwUzNZVi9UZ0NnZjdUdURKRks3TnE2ZXVRZmhTOXVKbk9T?=
 =?utf-8?B?MU5DUjcwcmdGTGJieGxxYVE5dWZIQ3R6TXliS0EzVVc2YTAvaU5nUElyQjBv?=
 =?utf-8?B?WWFKUVJkRXVYWjZuaXVaaVNZTkV2dVBtY3F4TzhHZk5KVTJlOXdpRWtOSnRl?=
 =?utf-8?B?S1Z5cVU5T2NHZ3E0QXNMbER0ZTZUckJsbHhmeS9QYUxkUFlHa0c5VEdsbnR1?=
 =?utf-8?B?ZkRKNnlISXU4cjQ3cGRZRVpjVlErSWt1U1owRWd1SGUwdFVQNXgzZFdGTTlE?=
 =?utf-8?B?WFpNQ0ExUWRqQ0VmMnpUYWw5QzQxNFNBekxSSlBqdjdiOCtlZ2lHYk0xMlU3?=
 =?utf-8?B?d2JEdytZR2gxR2VWeDMzZWxJb3dDTG8rcjhELzI1K2hNNDg0Ymo0c0x4eEhN?=
 =?utf-8?B?bEJHY3VLQlpFRzd5QzJmYjZxK1dsdkVua2xrZGlVZmtLVWhiZndjZGUwM3Ez?=
 =?utf-8?B?Z2xkQkRvM3hwS3ltdzRIRmpJMHlqQnFTTWdKVGVMT0YrM0xkSDR2dVV1VC96?=
 =?utf-8?B?NWFwRHJhWHBkdHg3WUcrRXdYeEdEYmVkS2lmT1dTdlhIK1hrSEVqaXVETFE0?=
 =?utf-8?B?Vmo5RUZwclEwcmVZNzBybEw5VjV4NGVTd0ROa0s3SUM5SUVjY3VTdkdrRHg3?=
 =?utf-8?B?R2IrOWUwdENMbFRycUxiVlFjdXBqUTBxWFJ3TU1BM0hZSlowcDArTGVTRnE3?=
 =?utf-8?B?YUFONFFnM21pM3RJWFJDSGF6QVQwaGtVcGtDdTVwdlpGU2FMSUFsemxqUytw?=
 =?utf-8?B?WkFSNDM4QmZwNVlMelhKck1KdHVsMnA0blVyYjFIbnAwcXlIUE0xMjZROHVq?=
 =?utf-8?B?TnVNb29lK1JxSHlFRGVaZnpGY2xIYXVZZjJYcGhZZUNjWjBpQ210WEI5UHhP?=
 =?utf-8?B?aDRjYmF1ejFXSTFLZ3RpeEJyYkRiTk03dGhLVUlEWlczNmk3azVPQ2ZHUndY?=
 =?utf-8?B?S2FDbndLa1NldktvSGVtODJEMEdETkZ6aUVIWEh3dVBCc3dDVHFyUk40dXJK?=
 =?utf-8?B?dk80aGNUSWpTSVh5aEQ3d1RRUEhzaDd6Q084a21kbmpPNDczOU50aVRuazZH?=
 =?utf-8?B?MjlLWlFwU0NtdEJMMmFJV2tXNVdGNjhyQVAvRSswZm1TVkRRWE4xN2dDTC9O?=
 =?utf-8?B?YVQ0SE1UMmJseGE3NFJhVXhQRDJ1Mmx2VUQ2M3ZLOXhWTFZrYjFNcXJUUE54?=
 =?utf-8?B?ai9OKzJBd1BORk1jalpyRGJCVGh6WmNCSWYyRzFpRmM5a05OcWNpZzBZeE43?=
 =?utf-8?B?RWo0WWtWNkI5YjhrWUw5NTgvMnNObC9jQ3E3cDhVdTYzTFVIUHc1dG11eFNM?=
 =?utf-8?B?ZUxMME9UWEFDNkpYU1hpMDdOYkFWRnluT0xleDNlRW5ZbHpvWFo3eTBNcFJn?=
 =?utf-8?Q?gfhFn9CDn1CWxq7QMLUIYjkrn594qmQH?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR10MB7730.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?aDJTWk9jYmxpTEhqZUN2dStaZ0VJLy8yc3J2Rk5WcDhWSmc4bzUvY215ZEQ2?=
 =?utf-8?B?T2hCTzYrKy9FdVVHM0tQYnZObGNBNUFrMGpjanovdTIwUWJhYTM2a1VJbk1o?=
 =?utf-8?B?T1JUdHlzczUvRStnNHpnZzRLUFNhZ2s3L0lkVlV2MFNvRzRVaDNMYmNmVkp5?=
 =?utf-8?B?ZW1PcWVGQXdId0REaGZybEQzOENtUTZNYjVray9ZZnduOEZHSVhwUUJaNlRJ?=
 =?utf-8?B?Y2kwUFZCK0Vhbk5PZWJJbUFNN2pHelF4Z0VoSTd5QlJqYUVUZmZ3ZWk5d2Rx?=
 =?utf-8?B?S2NvQU1aSnVaWHpIOUwzL0pBNGNVTUNxR2FyQnZUZEpoc0lJVDhZMjhiQXBJ?=
 =?utf-8?B?MVJUNjBXa3UrVDUvNGtHVGQyUWtzWHZUdHVmcC9vS291OVhSQVVJd09zbjda?=
 =?utf-8?B?ZXc3MkViYlhwS3ZuVkZSbFNzWVpoUHZscjZKNlZmbFk4SkRSWjlMWjJzcUZu?=
 =?utf-8?B?ZDFKeVFtM1ZrOFFKc3M1ajZiQTE2a0ZFU3JLZEpKYUFpL0xmQTlIalhRNFVq?=
 =?utf-8?B?bEV1WmpoTUNkMHJwZFo5b0NHVGNvM2pmSll2ZnI4R0ZUWjdLNCsvUnZqSEZR?=
 =?utf-8?B?bXBUZDBaZVZrOXNsYTlpNEVEcS9UajVKSFNFVzBYSkhWV2Y0eDVmNE9UOU42?=
 =?utf-8?B?SWhrN3gxaHNiaHh3RjdrckROZkpZZWNWbFAvb0hkbjdzMTBKUlZNZHk3U2U3?=
 =?utf-8?B?ZnFUOG5UN3FZL2xQY3VaUnNnQWtIVElGRDFLcEdwbEE4d0dzMWpmejQ5ejgv?=
 =?utf-8?B?Ky96SXlaSXRwczc4R2xLMlNUQ2FNc09vNjJLajczZndMU3hFVFhUUWxFQmRh?=
 =?utf-8?B?SWFENzUrbGc3ZTRvV0NqQ2VIbkM4YXdremEzK3pGZEVaUXhicWVyM3NyL2xz?=
 =?utf-8?B?ekFMaW1LMGc0bElqVTlJY3VZRzRYKzMycXlRVEw5S1pGc2JYU3hjNzJGYm9w?=
 =?utf-8?B?Uy80WWdDdXgyeVNrZG9weGxKb2pkZ0RjYWN0bFhCQ3RVYTg5WmxmYzBJMTBh?=
 =?utf-8?B?bXV6elBJR2t5SEVJOThDK0d1WE5rSGFKcXBSU2c2QjBBS3lhdjVDbldRaE13?=
 =?utf-8?B?K2RtK1RrTitUejBCUEQ3RVRHdnFMK2RZelJNU05FeTVpMlFUNjNwcEdTMTgy?=
 =?utf-8?B?amJEWFFIemxVYnJYcHF0dmdzZGhkdzFkQ3M0N2RnMlhnRW5QdFpOL2Q3d0xs?=
 =?utf-8?B?YWc0ZkEveENGR0xHRVZsckJ4VGV6dVBOSUNnNzc3bjJBTy9iYWRiTSszR2VP?=
 =?utf-8?B?Ymk1a2tSMWc0WlZXT2I5Tm5CVVRwSitmZ3F4czdod1ZvZ1NNU1ZLbUJTTUhQ?=
 =?utf-8?B?RjRjcUlBL1VhRnV2b1UwSmRiUmU3dHFockl5N0FENHcrRXFiZFdNTUxTUWFT?=
 =?utf-8?B?VEdFV2M5SFROVEUzV0RkRlA0Sm1TbkxORVd2UGtka1hnRFRjTFFjRExGd09H?=
 =?utf-8?B?UHYxMCt6cDE0blg2Qk9UQWdSSld0M25BTGFiZnpoNk0vOE9ZVElYUFJqdURa?=
 =?utf-8?B?YldMd0d1dzhLazVidnpDY2EwbkVmbFF1UzVxVy84aHhoYlhITlNtRitPeE5M?=
 =?utf-8?B?NXBpZnFiTE9YTXIxN0V3SWZ3VGg1QTl2NCtzK2tpV241Z3BUZ0JsU014VSt1?=
 =?utf-8?B?eWE5NUhZajBvUlBPdU5zaTJIcEhjWk14MkV2NzZoaHZFSGlaUklvdE1kQ0I2?=
 =?utf-8?B?akZwa09KT0NrWHNLejhWWFFiSGx4OTJ0WFV1ZUk2UTBEZDNERVFiQU9IdlFz?=
 =?utf-8?B?a2xrVkdrTFVKaGkwN3BXNDdpb1ErMWVxaE9MZk1KeFBRbVhna0FlSTBvT0hE?=
 =?utf-8?B?cXpRTzJDTGRmNU1wQmZEVXpzdklXQXdUMlg3aW90RmEwWXNrNkFRYVBBWW1Q?=
 =?utf-8?B?bVZVeHVVK1BpTkV6YzN5eVJCOGJBWHV2cVdxT3dBMHNSa2NjM2FSelh2MHZs?=
 =?utf-8?B?Sm8rQlphekJUTmhVcXk0MUFkalV5QlkzeFNEb2RQaXB2eUlMYXk3R3ZOSmdq?=
 =?utf-8?B?YnljT3Bqblk5Nzd4Q3g2bjBrTEVUNVozTDFON3AzbVNKK3I0cDFGRW1VQzB0?=
 =?utf-8?B?cjJPdG5iaFhGbC9VTllzclIxdW44L05Obkg3RmlJN2lPRGdnRXhxTkdUSUp4?=
 =?utf-8?B?c1JoRCs1QzY4V0orYVVtOGtBdERZcmVXQTB4b201MlVpTEdQemhaZ20yeURG?=
 =?utf-8?B?Y3c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <51836588A07ECE49BC053FD2EA39B5C9@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Ti4QyN46ks7tlBLuUq3iA/QBGQVuIUzBfuqSfbkz6TshNkPfzL1twbSQUxtQOyGU4YL/dcWjy+yztlyBfAcJRISVOpYBhwKZgJOU+2j3esdsWRTOOTqjka8QHeleKMowkFvcggY3wcKJz1uPdo/pq6vxAh505Iany7xkqkfInrCByMMv0ZbpojU5tajYBgfOvI6a23bZSnnEOJOTtaD+J7EKB9GRSCjH5aKZF175a6TVGizFa2KnteTwKQTI/SP3EgK5riIXsw3qLT58IHmZuohyoYFd8Iao/70luUnMHB4b5w6yoZw8a7Tsw6VUyCHyalohbOF1pKBZ7u1DebRZpkaBtjUKfkRjKK002XxAq5fQuw4d4XSaSsnTc0tIYlbzlQD0G4/ZNcjIePc+vWC9Xl3oPQJYQ1wgminKuXiJoU1IKonnxaJPw3VvLDyKsoKGKusXditQMmjSo2Eti4G10jIOb6JC25ywo7jE+dkifkqUcZ1SEIjOpwLs7PMOIlmX3qz/gxtfGnfYNaYRXaR9sLCt0Pi3KUFnseROmLd/8rh+Gm4uxYWUGvMJn3t6OAVpsF0fdJfbzyQ75pryrg0DY484ldQCcstUk7BoeqDqbgk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR10MB7730.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65fe5641-2fbb-4706-2622-08dd5c2cd8d3
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Mar 2025 21:29:44.1938
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kbZVwjW+4E4roo0tejjh2taOIW5PAN7jIBxh0NQItwkKBZTsguIdiSrVsqe6NegH8wdhmV0xa7bLUNgiGXFTHCOP1YCpFM+UBEhIymXt9Jw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4605
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-05_09,2025-03-05_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 suspectscore=0 spamscore=0
 mlxscore=0 mlxlogscore=999 adultscore=0 malwarescore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502100000
 definitions=main-2503050165
X-Proofpoint-ORIG-GUID: A7D1QwZVKNrg79BiYXfL43rUC2QiTmc5
X-Proofpoint-GUID: A7D1QwZVKNrg79BiYXfL43rUC2QiTmc5

DQoNCj4gT24gTWFyIDQsIDIwMjUsIGF0IDU6MjPigK9QTSwgUGF1bCBNb29yZSA8cGF1bEBwYXVs
LW1vb3JlLmNvbT4gd3JvdGU6DQo+IA0KPiBPbiBUdWUsIE1hciA0LCAyMDI1IGF0IDk6NDfigK9B
TSBFcmljIFNub3diZXJnIDxlcmljLnNub3diZXJnQG9yYWNsZS5jb20+IHdyb3RlOg0KPj4+IE9u
IE1hciAzLCAyMDI1LCBhdCAzOjQw4oCvUE0sIFBhdWwgTW9vcmUgPHBhdWxAcGF1bC1tb29yZS5j
b20+IHdyb3RlOg0KPj4+IE9uIEZyaSwgRmViIDI4LCAyMDI1IGF0IDEyOjUy4oCvUE0gRXJpYyBT
bm93YmVyZyA8ZXJpYy5zbm93YmVyZ0BvcmFjbGUuY29tPiB3cm90ZToNCj4+Pj4+IE9uIEZlYiAy
OCwgMjAyNSwgYXQgOToxNOKAr0FNLCBQYXVsIE1vb3JlIDxwYXVsQHBhdWwtbW9vcmUuY29tPiB3
cm90ZToNCj4+Pj4+IE9uIEZyaSwgRmViIDI4LCAyMDI1IGF0IDk6MDnigK9BTSBNaW1pIFpvaGFy
IDx6b2hhckBsaW51eC5pYm0uY29tPiB3cm90ZToNCj4+Pj4+PiBPbiBUaHUsIDIwMjUtMDItMjcg
YXQgMTc6MjIgLTA1MDAsIFBhdWwgTW9vcmUgd3JvdGU6DQo+Pj4+Pj4+IA0KPj4+Pj4+PiBJJ2Qg
c3RpbGwgYWxzbyBsaWtlIHRvIHNlZSBzb21lIGRpc2N1c3Npb24gYWJvdXQgbW92aW5nIHRvd2Fy
ZHMgdGhlDQo+Pj4+Pj4+IGFkZGl0aW9uIG9mIGtleXJpbmdzIG9yaWVudGVkIHRvd2FyZHMgdXNh
Z2UgaW5zdGVhZCBvZiBsaW1pdGluZw0KPj4+Pj4+PiBvdXJzZWx2ZXMgdG8ga2V5cmluZ3MgdGhh
dCBhcmUgb3JpZW50ZWQgb24gdGhlIHNvdXJjZSBvZiB0aGUga2V5cy4NCj4+Pj4+Pj4gUGVyaGFw
cyBJJ20gbWlzc2luZyBzb21lIGltcG9ydGFudCBkZXRhaWwgd2hpY2ggbWFrZXMgdGhpcw0KPj4+
Pj4+PiBpbXByYWN0aWNhbCwgYnV0IGl0IHNlZW1zIGxpa2UgYW4gb2J2aW91cyBpbXByb3ZlbWVu
dCB0byBtZSBhbmQgd291bGQNCj4+Pj4+Pj4gZ28gYSBsb25nIHdheSB0b3dhcmRzIHNvbHZpbmcg
c29tZSBvZiB0aGUgcHJvYmxlbXMgdGhhdCB3ZSB0eXBpY2FsbHkNCj4+Pj4+Pj4gc2VlIHdpdGgg
a2VybmVsIGtleXMuDQo+Pj4+IA0KPj4+PiBUaGUgaW50ZW50IGlzIG5vdCB0byBsaW1pdCBvdXJz
ZWx2ZXMgdG8gdGhlIHNvdXJjZSBvZiB0aGUga2V5LiAgVGhlIG1haW4NCj4+Pj4gcG9pbnQgb2Yg
Q2xhdmlzIGlzIHRvIGFsbG93IHRoZSBlbmQtdXNlciB0byBkZXRlcm1pbmUgd2hhdCBrZXJuZWwg
a2V5cw0KPj4+PiB0aGV5IHdhbnQgdG8gdHJ1c3QgYW5kIGZvciB3aGF0IHB1cnBvc2UsIGlycmVz
cGVjdGl2ZSBvZiB0aGUgb3JpZ2luYXRpbmcNCj4+Pj4gc291cmNlICguYnVpbHRpbl90cnVzdGVk
LCAuc2Vjb25kYXJ5LCAubWFjaGluZSwgb3IgLnBsYXRmb3JtKS4gSWYgd2UgY291bGQNCj4+Pj4g
Z28gYmFjayBpbiB0aW1lLCBpbmRpdmlkdWFsIGtleXJpbmdzIGNvdWxkIGJlIGNyZWF0ZWQgdGhh
dCBhcmUgb3JpZW50ZWQNCj4+Pj4gdG93YXJkIHVzYWdlLiAgIFRoZSBpZGVhIGZvciBpbnRyb2R1
Y2luZyBDbGF2aXMgaXMgdG8gYnJpZGdlIHdoYXQgd2UNCj4+Pj4gaGF2ZSB0b2RheSB3aXRoIGtl
cm5lbCBrZXlzIGFuZCBhbGxvdyB0aGVtIHRvIGJlIHVzYWdlIGJhc2VkLg0KPj4+IA0KPj4+IFdo
aWxlIGl0IGlzIHVubGlrZWx5IHRoYXQgdGhlIGN1cnJlbnQgd2VsbCBrbm93biBrZXlyaW5ncyBj
b3VsZCBiZQ0KPj4+IHJlbW92ZWQsIEkgc2VlIG5vIHJlYXNvbiB3aHkgbmV3IHVzYWdlIG9yaWVu
dGVkIGtleXJpbmdzIGNvdWxkIG5vdCBiZQ0KPj4+IGludHJvZHVjZWQuICBXZSd2ZSBzZWVuIGZh
ciBtb3JlIHNpZ25pZmljYW50IHNoaWZ0cyBpbiB0aGUga2VybmVsIG92ZXINCj4+PiB0aGUgeWVh
cnMuDQo+PiANCj4+IENvdWxkIHlvdSBmdXJ0aGVyIGNsYXJpZnkgaG93IGEgdXNhZ2Ugb3JpZW50
ZWQga2V5cmluZyB3b3VsZCB3b3JrPyAgRm9yDQo+PiBleGFtcGxlLCBpZiBhIGtlcm5lbCBtb2R1
bGUga2V5cmluZyB3YXMgYWRkZWQsIGhvdyB3b3VsZCB0aGUgZW5kLXVzZXINCj4+IGFkZCBrZXlz
IHRvIGl0IHdoaWxlIG1haW50YWluaW5nIGEgcm9vdCBvZiB0cnVzdD8NCj4gDQo+IENvbnNpZGVy
IGl0IGFuIGV4ZXJjaXNlIGxlZnQgdG8gdGhlIHJlYWRlciA6KQ0KPiANCj4gSSBpbWFnaW5lIHRo
ZXJlIGFyZSBkaWZmZXJlbnQgd2F5cyBvbmUgY291bGQgZG8gdGhhdCwgZWl0aGVyIHVzaW5nDQo+
IHRyYWRpdGlvbmFsIHVzZXIvZ3JvdXAvY2FwYWJpbGl0eSBwZXJtaXNzaW9ucyBhbmQvb3IgTFNN
IHBlcm1pc3Npb25zLA0KPiBpdCB3b3VsZCBkZXBlbmQgb24gdGhlIGVudmlyb25tZW50IGFuZCB0
aGUgc2VjdXJpdHkgZ29hbHMgb2YgdGhlDQo+IG92ZXJhbGwgc3lzdGVtLg0KDQpUaGVzZSBrZXlz
IGFyZSB1c2VkIGJ5IHRoZSBMb2NrZG93biBMU00gdG8gcHJvdmlkZSBzaWduYXR1cmUgDQp2YWxp
ZGF0aW9uLg0KDQpJIHJlYWxpemUgdGhlIGNvbnRlbnRzIHRoYXQgZm9sbG93IGluIHRoaXMgcGFy
YWdyYXBoIGlzIG91dHNpZGUgdGhlIA0KYm91bmRhcnkgb2YgbWFpbmxpbmUga2VybmVsIGNvZGUu
ICBFdmVyeSBkaXN0cm8gdGhhdCB3YW50cyB0aGVpciANCnNoaW0gc2lnbmVkIG11c3QgZXhwbGFp
biBob3cgdGhlaXIga2VybmVsIGVuZm9yY2VzIGxvY2tkb3duIA0KbW9kZS4gIFRoZSBtaW5pbXVt
IHJlcXVpcmVtZW50IGlzIGxvY2tkb3duIGluIGludGVncml0eSBtb2RlLiAgDQpBbHNvLCB0aGUg
ZXhwZWN0YXRpb24gaXMgbG9ja2Rvd24gZW5mb3JjZW1lbnQgY29udGludWVzIG9uIA0KdGhyb3Vn
aCBhIGtleGVjLg0KDQpXaGVuIGluIGxvY2tkb3duIGludGVncml0eSBtb2RlLCBmZWF0dXJlcyB0
aGF0IGFsbG93IHRoZSBrZXJuZWwgDQp0byBiZSBtb2RpZmllZCBhdCBydW50aW1lIGFyZSBkaXNh
YmxlZC4gIEhvdyB3b3VsZCB3aGF0IHlvdSBoYXZlIA0Kc3VnZ2VzdGVkIGFib3ZlIGFkaGVyZSB0
byB0aGVzZSBnb2Fscz8NCg0KVGhlIHBvaW50IG9mIHRoZSBDbGF2aXMgTFNNIGlzIHRvIHVzZSB0
aGUgcm9vdCBvZiB0cnVzdCBwcm92aWRlZCB0byANCnRoZSBrZXJuZWwgcHJpb3IgdG8gaXQgYm9v
dGluZy4gVGhpcyBtYWludGFpbnMgdGhlIGxvY2tkb3duIGludGVncml0eSANCmdvYWxzLCB3aGls
ZSBhbHNvIGdpdmluZyB0aGUgZW5kLXVzZXIgdGhlIGFiaWxpdHkgdG8gZGV0ZXJtaW5lIGhvdyAN
Cmtlcm5lbCBrZXlzIGFyZSB1c2VkLg0KDQoNCg==

