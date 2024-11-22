Return-Path: <linux-efi+bounces-2190-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D486D9D666C
	for <lists+linux-efi@lfdr.de>; Sat, 23 Nov 2024 00:43:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9501F2835DF
	for <lists+linux-efi@lfdr.de>; Fri, 22 Nov 2024 23:43:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E60E11BD9E4;
	Fri, 22 Nov 2024 23:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="osLtC6h5";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="q6avcAvj"
X-Original-To: linux-efi@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C231518CC01;
	Fri, 22 Nov 2024 23:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732319034; cv=fail; b=sEBxbfcUwGJ/SQcjaO0rz+PLCcqMMphKUqu34r0qFi6wiqV6csO7jVlhG4sA+SSRB5lcMwT6IrqsbEIWlp7AmjAS2ZfUK73YFHTqcfadZi/phW/3CmrmGW1DwNJXsM8kip+TGEOK063jHId4Qo1dJ4/nKERVemDEFJVwNnfh+vM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732319034; c=relaxed/simple;
	bh=QgvXVjupNvlUM0M4FwQ3mKY/EYqirK4Y/+1C1bCjTcM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=iF5SjSrepYL47GJW8+JLz1P25lGiOu9tH1XiowzQSXpXzE18mKKngIHFH913lOs7kCJ8ACHeVECAGLPpFu+QTzbxEIpKrWQoCNIc2gD/iVJXalpfP2zsRuL0yg05W3zqUoJ1cy/Yqx0Tmxd/pReRGbhMmE70dHMpWOGshT+KodY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=osLtC6h5; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=q6avcAvj; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AMLfOff011148;
	Fri, 22 Nov 2024 23:37:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=+5bYl7HmFPqRJD29pVzKNiRfRWptOjb4lKOykaGHVy4=; b=
	osLtC6h56fX9kCRWhYM9prKmys+dfWa0wA6WKrozizJqWbSkdMBHRFX5qRdo5K7R
	XsjZwFt7yDFrxGLp6FWGmOWC7i/CAfcrC8l8yZ7h86nzcVBbFCeGpO5yrow9CiaZ
	ZGIai152eYKoDsPVGkGmx96/08qmMAsX1oe+DG/WFlM03/mu+C7+sUo+HMqiff6c
	NrIEnmfs0cTushcLex5vnTJuSwYyKvFFamw/ZJgtcpUnXjcBE/wh1VuHArgXoDQb
	TvzLeDNKQ8rkraB5gX9U36KMkuTY+w/GK/6oMnIowf2W5muEiVSuBwe5/5NKyvu6
	eY8mr/pIG5/jJnkePgQ2og==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4331vpr58w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 22 Nov 2024 23:37:48 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4AMMhSLw039850;
	Fri, 22 Nov 2024 23:37:47 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2172.outbound.protection.outlook.com [104.47.57.172])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 42xhudsb77-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 22 Nov 2024 23:37:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d5q3Um9yBXo5rOfUSpl/AU8OU8QrWYcEpO5ziieWsPanxAAcM3NYEhsl5Mv8W2tZQkVRiOTp+4b4ZylSZR/kCJgAnCYYKz9WEmPUjXkPhgX/fr+LIKMJg+IAMmmCrSJtnloOWj0mN8bh33nVORxo1/5EuqOXxA95odpUrfpAwwnisvc2SM84ug5RAJwMFCksRZZcFDBMj8KX6bBuh6w1xgdJWZztgRuFuDROivYefxZJ2/9rz+7egMUi2+RIT1XOpyd3KA+gGFjI96KSSkge9bLZWlmM5mmprripnecxksDb2ygkRQsHyU+0irDfHQCqht6CBMp6LeWWEMfRkQ5vxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+5bYl7HmFPqRJD29pVzKNiRfRWptOjb4lKOykaGHVy4=;
 b=gR1cC/vjeDtugkR+nWU90xHBKzDxOU37zQs0whVvDqPFUymvwbClKNojkl3u++BF0oFPuaToKpVUsZbpj9S71PzlMRzM1yoTijlbBKF6AGWEWVrlRdzvjcGUqsAWiep1GExDYZeNT3hR/zfVFHKnctmH7aeP3vBw8o90aVq6W+mY2E+Oen8TluDnikCQFIPVC7zcgIK5/a/R10hjAyN2rSI/e51xUiUfxHmQh3r8MJ2DSUJdcvHgzvh5S3rpIT0idIhhOmiPpeaUzJpeQpanc7ucAh6CYbFsibQ47q0HAq6NiFj1K4mXlhz++nV8oJrzJZRxpUixCBwpHB0CkwEzjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+5bYl7HmFPqRJD29pVzKNiRfRWptOjb4lKOykaGHVy4=;
 b=q6avcAvjlmWGufxf1UcWA0GfE3UOiDe0EtXIFNFcqjzeHhYMi9R8JwThOs8Qky03bNqdW/v0YxdlRXRJ5gYOFWjxZAZYtj5i8uXdy2BJkLQATzwFHIgs1d+IcbCRAC173gHqCQuKt8mP3uhDMsSZgmayBSSOFv36+mLYpRf0y1w=
Received: from DS0PR10MB7224.namprd10.prod.outlook.com (2603:10b6:8:f5::14) by
 SJ2PR10MB6961.namprd10.prod.outlook.com (2603:10b6:a03:4d1::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.23; Fri, 22 Nov
 2024 23:37:44 +0000
Received: from DS0PR10MB7224.namprd10.prod.outlook.com
 ([fe80::c57:383f:cfb2:47f8]) by DS0PR10MB7224.namprd10.prod.outlook.com
 ([fe80::c57:383f:cfb2:47f8%4]) with mapi id 15.20.8158.019; Fri, 22 Nov 2024
 23:37:44 +0000
Message-ID: <2a243379-f18e-4461-95ad-c17ce49e6641@oracle.com>
Date: Fri, 22 Nov 2024 15:37:36 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 06/19] x86: Add early SHA-1 support for Secure Launch
 early measurements
To: Andy Lutomirski <luto@amacapital.net>
Cc: James Bottomley <James.Bottomley@hansenpartnership.com>,
        "Daniel P. Smith" <dpsmith@apertussolutions.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Eric Biggers <ebiggers@kernel.org>, linux-kernel@vger.kernel.org,
        x86@kernel.org, linux-integrity@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-crypto@vger.kernel.org,
        kexec@lists.infradead.org, linux-efi@vger.kernel.org,
        iommu@lists.linux-foundation.org, mingo@redhat.com, bp@alien8.de,
        hpa@zytor.com, dave.hansen@linux.intel.com, ardb@kernel.org,
        mjg59@srcf.ucam.org, peterhuewe@gmx.de, jarkko@kernel.org,
        jgg@ziepe.ca, nivedita@alum.mit.edu, herbert@gondor.apana.org.au,
        davem@davemloft.net, corbet@lwn.net, dwmw2@infradead.org,
        baolu.lu@linux.intel.com, kanth.ghatraju@oracle.com,
        andrew.cooper3@citrix.com, trenchboot-devel@googlegroups.com
References: <20240531010331.134441-1-ross.philipson@oracle.com>
 <1a1f0c41-70de-4f46-b91d-6dc7176893ee@apertussolutions.com>
 <8a0b59a4-a5a2-42ae-bc1c-1ddc8f2aad16@apertussolutions.com>
 <CALCETrX8caT5qvCUu24hQfxUF_wUC2XdGpS2YFP6SR++7FiM3Q@mail.gmail.com>
 <c466ed57-35a8-41c0-9647-c70e588ad1d3@apertussolutions.com>
 <CALCETrW9WNNGh1dEPKfQoeU+m5q6_m97d0_bzRkZsv2LxqB_ew@mail.gmail.com>
 <ff0c8eed-8981-48c4-81d9-56b040ef1c7b@apertussolutions.com>
 <446cf9c70184885e4cec6dd4514ae8daf7accdcb.camel@HansenPartnership.com>
 <5d1e41d6-b467-4013-a0d0-45f9511c15c6@apertussolutions.com>
 <CALCETrW6vMYZo-b7N9ojVSeZLVxhZjLBjnMHsULMGP6TaVYRHA@mail.gmail.com>
 <9c80e779b6268fde33c93ed3765ff93b1d6d007b.camel@HansenPartnership.com>
 <CALCETrX4vHnVorqWjPEOP0XLaA0uUWkKikDcCXWtbs2a7EBuiA@mail.gmail.com>
 <66fabe21-7d0d-4978-806e-9a4af3e9257a@oracle.com>
 <CALCETrXXsta0OdgXb5Ti87psaty7gp5WRr-w8vTuEhOLuoGyXg@mail.gmail.com>
 <CALCETrV=PSLvDn4K6o1qoQLwTQtaPU6ESVPZTwRBJF5Pj_XJwg@mail.gmail.com>
Content-Language: en-US
From: ross.philipson@oracle.com
In-Reply-To: <CALCETrV=PSLvDn4K6o1qoQLwTQtaPU6ESVPZTwRBJF5Pj_XJwg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BN0PR03CA0009.namprd03.prod.outlook.com
 (2603:10b6:408:e6::14) To DS0PR10MB7224.namprd10.prod.outlook.com
 (2603:10b6:8:f5::14)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7224:EE_|SJ2PR10MB6961:EE_
X-MS-Office365-Filtering-Correlation-Id: 6046a0d8-3124-4974-897e-08dd0b4ea9ab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Zm9hUm9rcWEyQ0VBMFpGeE0rdFB1ejQzemkyZXNXS2tmMW50bHJjaklVa2Y3?=
 =?utf-8?B?V0U5cTkxZVBPLzVob2dNMmxOcHoyQ1NOdDFvN1hIRng5Ui9PcHFIRGlpS1M1?=
 =?utf-8?B?QkZpVkFtVnV4Y3lmVDVuSnNFcWpMYnFvMk9ZeUxYMWR4NHc0Zk8yWlBuSFRQ?=
 =?utf-8?B?NHZFNzVZdEppUWxiU2JWaXE5VmY2dzJaV2pYRE9xeUE0T1dXcThwRUhlYkhT?=
 =?utf-8?B?UU5tdDNSTEdHTkpIcU1UYTlheFBXOWpZNkJxL241M2NLVUEzdU1IOWlZM3pK?=
 =?utf-8?B?dFFoT3RGVE9tYUxwTlF1UlZsNUNOL25YVWsycXdyenBjWFpuUHlQODVhU1hs?=
 =?utf-8?B?aFdsSWZpVmQ4MjgwaEJLdmd0aGppcWlTTXNyeno4R2JoOHJxMDh4dGhocm8y?=
 =?utf-8?B?R1RiRVBkQ2RjaUhSN0pVcGRJL21pMVVhNHdtM0RFR0lnR1B0Z1hGUVZWbnUw?=
 =?utf-8?B?MXlvOTBnbzZWY3RZNmhlTjUyQTh2dUdZaEZYWlRmd0JKZW5pWDc4Nk5kdXMy?=
 =?utf-8?B?NWR6QkdDRFlpc3lCeWxsdmczUWpWc3Y3QUU3aWpzcTR5a1FhU0xHVUw0c2Nj?=
 =?utf-8?B?eDhpUWxvU1AvMThKRW1sb0xPR2ZmWWcvWVExbU5KU2pxYUNpOVNXR3JVT1Rw?=
 =?utf-8?B?V1VFUWdhMG9nUlZ4dHZQcmtIRU5mQmVSNnVLZHZyMHQvanV3SDBIZEp6amJx?=
 =?utf-8?B?eExmY2MzYm4waGZnREtMcktyRE44eFNvNGNlS2hTVHV3TmZWOHFoNnhlamNJ?=
 =?utf-8?B?MWV5NWtBK1pIdWV5WTRNWlVWMzltUy9QTS96cUV0V2hBbGxnTXpqSWdza0Zj?=
 =?utf-8?B?WVBLeHVIWlc4bVpJSU5kblBvZFZBWllzVU5jbWN4UUFLUUtzV0grRk1FSnU3?=
 =?utf-8?B?RXN5bmVubmpla0ZZMllHR2taT0hYNXkzTWxuZlBHU0k5Q2FiaHc0c1ZsRXB4?=
 =?utf-8?B?R01wM3BSZjZqZmZDV1N1dEVVWTk0TDhTMVErNEFtZWVva1ZJajZOdjFrR2Zp?=
 =?utf-8?B?NHBBNW1XOUR1YUtNQXlpbHhTbTdzcFdVU1JOc2J5QzhJVmtETERKdUczbEpT?=
 =?utf-8?B?OG5RNVVyTCsvQjVGT2hkUGVkekhONTJFZFlja0orcGdWQnp6dVR1bTBhZUpE?=
 =?utf-8?B?TDk5OUxnalRscWtQMm1xMlZWZHBWcG5iYlU4VnVLRENqZ2dDTytHWndMMVJN?=
 =?utf-8?B?VDhNRWxmZDU4R29zMUJNeE5TT1o3MXNNamZtblozRlFvUDI2TWFXTTRFRE9L?=
 =?utf-8?B?T0FRVHNVSFIvQmhUclBGaVp2Nk1VNDBHZ3lSeUx6THg5NW5SOW9CNGJabHcy?=
 =?utf-8?B?Y2wwNGVxQ0NHOSt2M0VnWUdZNVR4dlJHd0pUV2xwM3JKaFl1UU05bWhoYmxN?=
 =?utf-8?B?akM3V2IvZ2phaGt6Q09iOXNheTk2UDhlcEZIdGpCUVl2ejB5UVEyQU94VnNT?=
 =?utf-8?B?Vnhqbk9xTklQbzVGVW1vTVphbEVlc1c5Q0I4WFkzc2VhbnJlcENwNDRSdkM1?=
 =?utf-8?B?UkIxZGViek5iWitkRFRmM0UvM0themtndW0yVlFrNXhpSjdadmEySjZVZTdF?=
 =?utf-8?B?ZXcrbWhJNllDdUFWM0dOVWVaYmFsQ0x1YWpiWDg4UFd5Rk5reHdTZXpYdEhk?=
 =?utf-8?B?WS8ydmI4Q1lyaDlkWnNVWW5HRkRUZWRvQ25RVEV0RTQ4WkpCZVplMlBvdS83?=
 =?utf-8?B?YTR5L1RGbjBRS1JJdGRhREVGa0RtWlFGV1hJT05mREZCZ3QyVzVLTW9jSEpN?=
 =?utf-8?B?cjlERmNSR1pBL3BIM2FnWmlSWnZ0djRpTWZwd0ZaT0JPWFFtSEJNK1c1QWo0?=
 =?utf-8?B?YWQ0ZWpjOWdoZnpJamV0dz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7224.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?clRGUFc3VlBsdE1rWFNRaUZESlIxNVY1Z1hlaHJBSzY2aGRjdDYrRmxNZEhE?=
 =?utf-8?B?RU1rMkxUYjJoeHNpVWlOeWdpU05nY0FGcWx0Ry9oMlE0a1hjU0VKaXdYb21y?=
 =?utf-8?B?RlpieE5KUkRFakRrVGxCQm9HUnZEY3liZDdwendxWERBQmhrZXYwY3lEenlC?=
 =?utf-8?B?dzVLak9aMlpWQ2plYVR5eno1d2xPYzdmRkxBZWhHNzJSVlVNRzhCTnpOWi9h?=
 =?utf-8?B?eU9CcEVTMHJXQWY4cVNuL052YlRJdG9PTWppY1dRNm5VWjJ2SkkyRFllRGpm?=
 =?utf-8?B?N1VwOUJZcWZRNXFaT1NWVHdtSWM3ek5ZQ2tTWUhuKzFMNVUvZXIybHVGMTVy?=
 =?utf-8?B?YkhZRGhBR0FkUDl4R1hHZk41ZUI4OFFUWjFOdHVvckE0Y3ZWeFNPR2hSQURl?=
 =?utf-8?B?bnd6d3Q1VmNDbXNsUXdvVmpGTlAyRFpXS3l5VUlTZUdURk5rY2hXb2hPSkhP?=
 =?utf-8?B?NlJOZFl4UDUybXVIT1ZaL3JvNFU0Q3JrOEFyZjdUQ0ZLNklCNUJCczhDUW5o?=
 =?utf-8?B?cnJUZGdhM3puOVcvaDM0WXVSS3ltcHlUT2l6WWlDT2RjTWtzdWRyUEY5OUZQ?=
 =?utf-8?B?eE1ET3c0czJCRlFxdjFuOENnNzEyYW1vNG5PMmY1dXpYL1QzVXRteHhJMm9v?=
 =?utf-8?B?OFAvNWxibUpIV21adGo5Zm9CWjd0NFBkNHZyR0tiK1lCakk5TlZ0VUliSmhy?=
 =?utf-8?B?TkZFQXQvWWUwNEpZdnFHR2RDbEhGekpIcFpUNVB4TVhJVEY4TThxQ24yRG5B?=
 =?utf-8?B?VjJjSk5XQVFueU9hTWZnRU1XcDZsOVMzMmc4bnFFTGdkUy9PY0NMa1RvTzlr?=
 =?utf-8?B?S3pKbVZnS1NudDdHTHplQW9Lb052dzlkL0Nqd25NUW9nMy9Ba1RPWDBTMUV5?=
 =?utf-8?B?aTVDelgvNEJlTFdLQTFIYXdEOU12Yll4TlJWOWtxR0RsQzZzbGxCYlpia0Nl?=
 =?utf-8?B?TjQweU5wU0w5VThxTTF2VUNQSHo5dEhJVGFqYWJDL2tOUVZFTFNobFVQZXlU?=
 =?utf-8?B?NkJERE9XNGZHWVkzRS9QSTVyWnNUTVZ3SVV1bHV6Tk9uNFBKMmxtcnE2aEpj?=
 =?utf-8?B?aE5UVXMxZUZtd3FmbzU5N1hHeXJVUWlwMGpZQW1BZG9Ld05paWhYNFdGdUZq?=
 =?utf-8?B?TktwYmdVNTVoWW1IeG1LN1ZmcGtmOFdTNjhBQTlSM1lnMVg0M2t5aFFybzFk?=
 =?utf-8?B?enVLZDlBd21XWjFDT1ZyNVM2dkZQL0hYbzYrQTIrdHFpZFBnbEdMNlc2a2ZW?=
 =?utf-8?B?dFJkUGFvTVFvQU94Yi9wR3UrcmVPeDhCOER2bVgvTElWYnprQWh0b2FDbXpO?=
 =?utf-8?B?OGdDMkFVR3lYNW1CMXU2LzYrVldNZXN1aThSM2RueS95QVloWGVpVlZaZ0hj?=
 =?utf-8?B?TmZPTVVaMlMvdHVqMXFyekc0YjVLSE5tZTgwNGxtZ1Bud2pWb2ZkSGVjdlQ5?=
 =?utf-8?B?eExCRVp2MGRyRlN5VFZFN255eUhCeHBVNTZRNVFTdllWMGVUY1NVZjQ3ZFRU?=
 =?utf-8?B?S3M2R2xHUEVXZGhvN1QxaHdiTGJyUml6MXpnSmxaVkF5RWdrNWw2OG1abHBw?=
 =?utf-8?B?ZUQzdHlKb0lzTDdxU1I0a3FJVGs4QkdoWldNWmZnUlZNdXYzajE2Wi9sZkJu?=
 =?utf-8?B?NFVlZ3ZhOE1GN2NoSHg2bE1XSnFwdXFudzQ0Z3VuemZnR1c3dzZ5T01YdGxK?=
 =?utf-8?B?dmdPNFVLUUdNRmI1a3ZTOENDOWRoZ0RkNlBtbDcyTGw4eEpRbmxMNHNNK3VI?=
 =?utf-8?B?R3J5LzZNZFdnalhibVgzZzg2cnkzMWpQYitYbDZzM2NWempQTGloNEx0d1dK?=
 =?utf-8?B?MmprbnpwNWdJS1FTbllkcWNQR3pDQVJiaUhUMHl6bkNEYU9URjg1a0lpNGtI?=
 =?utf-8?B?QkNhSGhIN1ZMdVh4V05PcHNTaUFadzA4UU1tZlhCZGJGZWd1VVNycmFsbFRT?=
 =?utf-8?B?VC9JQ2RSa29WWUFVM2U0SmVlazMwRUZnV0E3c3FNRllOZ0YraXJLNzdWNVFx?=
 =?utf-8?B?bEdiS0VIMlFidWx2Y3Q2YXN2NFdkaWFkMmxEQllEem1XWTl3QUswZzRRbktX?=
 =?utf-8?B?cUxGRitsSDhNL0x5WFRoT3JaRzdNY0hXSTBac1BES0RCZ0ppQTBVNDk2VnRV?=
 =?utf-8?B?RFAvdm5hQkc2c1pjU29reW9mdnU4ejZaU2hXL1Z0WncxK1BVM3VHeStTV0pl?=
 =?utf-8?B?VlE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	hnWaGg36MvqtEy1dGJfX0M97YMdRomazryiFpekyYyh/9eSJjF+WdN+w9CnxwfWMXOKK5mZz57XE2VhoYNQwe+eWGyBZ5Av/Tqg6YiR9vxUTiuGLta5Yn5X1IeGRtTL0uS1yNgSONu0KhQD3vsW4XI8Zi3DmI1kK9prOMFSJf/ibMEQE5ms2eXv+1uO6syr03catY0owGvMNn4ogr0LeGZBa2FG/GIQY9Y1Bnbkw5fSG7S2TerYYpwon97RLxSbdXJyCcZzq2agudng0gFs8J5EG5QnRC8rSV2x/6m2On1OJsf0o9xDQU3ml7IVulrb5ycN4/lVv58oIsCff5Sjx+MSEk+39hnIOp5ieE8oUdcPzmYu7r/Udm4pnu94cH7C3Oh0lKsSxQ82nDAFfNwhUdfT4hu6oVazOmmv+3MSCBn6DN0BDKD4nludQ1MypU3lhXf9AIr3zNjm4G1llSDv1kxmj3KnjGjpFRfstTNPzH0jwlA6dTj++vv+aE2onNE7HpRbbw6LutDu93/E9eo0Xk+8p25XAZdNc2DQpg8rRv33BcH8HmUAP5U7UyhPvFVx2pD6Tz92XIArit6dwJo7MnR7LZfCuEtWCxgEnRiKFn4g=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6046a0d8-3124-4974-897e-08dd0b4ea9ab
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7224.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2024 23:37:44.1009
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZuiuXy3ljK05s++QNFIQcI8kuFwbquUuYXYKvorZ54nwNVCoZkMCzX2b5+NP1RFhU4TD2DxQj+vC/2w1xFrAdSLWSjfMQnkvhMIREvSb/MI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR10MB6961
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-22_14,2024-11-21_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 phishscore=0
 adultscore=0 mlxlogscore=999 bulkscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2411220200
X-Proofpoint-GUID: PzaCDD31pGccq9jg04vLpmwyAU09S2qv
X-Proofpoint-ORIG-GUID: PzaCDD31pGccq9jg04vLpmwyAU09S2qv

On 11/21/24 2:42 PM, Andy Lutomirski wrote:
> On Thu, Nov 21, 2024 at 12:54 PM Andy Lutomirski <luto@amacapital.net> wrote:
>>
>> On Thu, Nov 21, 2024 at 12:11 PM <ross.philipson@oracle.com> wrote:
>>>
>>> On 11/18/24 12:02 PM, Andy Lutomirski wrote:
>>
>>>> If the vendor of an attestation-dependent thing trusts SM3 but *Linux*
>>>> does not like SM3, then the vendor's software should not become wildly
>>>> insecure because Linux does not like SM3.  And, as that 2004 CVE
>>>> shows, even two groups that are nominally associated with Microsoft
>>>> can disagree on which banks they like, causing a vulnerability.
>>>
>>> Thanks everyone for all the feedback and discussions on this. I
>>> understand it is important and perhaps the Linux TPM code should be
>>> modified to do the extend operations differently but this seems like it
>>> is outside the scope of our Secure Launch feature patch set.
>>
>> It's absolutely not outside the scope.  Look, this is quoted verbatim
>> from your patchset (v11, but I don't think this has materially
>> changed):
> 

Concerning my previous response, I realized that I did not fully 
understand what you were suggesting/proposing so I am sorry about that. 
You are correct that addressing this is within the scope of what we are 
doing. I have reread all the emails again and I/we now understand what 
you are saying.

We are now exploring how we might use TPM2_PCR_Event, whether it 
introduces other issues with respect to how TXT/ACM might behave and 
what would be needed to adopt this approach. More to come on that front. 
I will mention that the TPM code in the Linux kernel does not currently 
support the TPM2_PCR_Event command. The functionality needs to be added 
and that needs buy in from the TPM maintainers (probably guidance too).

A bit more below to clarify a few things...

> 
> ... I apologize -- I've misread the code.  That code is still wrong, I
> think, but for an entirely different reason:
> 
>>
>> +       /* Early SL code ensured there was a max count of 2 digests */
>> +       for (i = 0; i < event->count; i++) {
>> +               dptr = (u8 *)alg_id_field + sizeof(u16);
>> +
>> +               for (j = 0; j < tpm->nr_allocated_banks; j++) {
>> +                       if (digests[j].alg_id != *alg_id_field)
>> +                               continue;
>>
>> ^^^^^^^^^^^^^^^^^^^^^ excuse me?
>>
>> +
>> +                       switch (digests[j].alg_id) {
>> +                       case TPM_ALG_SHA256:
>> +                               memcpy(&digests[j].digest[0], dptr,
>> +                                      SHA256_DIGEST_SIZE);
>> +                               alg_id_field = (u16 *)((u8 *)alg_id_field +
>> +                                       SHA256_DIGEST_SIZE + sizeof(u16));
>> +                               break;
>> +                       case TPM_ALG_SHA1:
>> +                               memcpy(&digests[j].digest[0], dptr,
>> +                                      SHA1_DIGEST_SIZE);
>> +                               alg_id_field = (u16 *)((u8 *)alg_id_field +
>> +                                       SHA1_DIGEST_SIZE + sizeof(u16));
>> +                               break;
>> +                       default:
>> +                               break;
>> +                       }
>> +               }
>> +       }
> 
> If we fall off the end of the loop, we never increase alg_id_field,
> and subsequent iterations will malfunction.  But we apparently will
> write zeros (or fail?) if we have an unsupported algorithm, because we
> are asking to extend all allocated banks.  I think.  This code is
> gross.  It's plausible that this whole sequence is impossible unless
> something malicious is going on.

Noted, there does look like there is an issue there. Thank you for the 
analysis.

> 
> Also, and I'm sort of replying to the wrong patch here, how
> trustworthy is the data that's used to populate tpm_algs in the stub?
> I don't think the results will be very pretty if tpm_algs ends up
> being incorrect.

We gather the list of algorithms used from the DRTM event log which the 
TXT/ACM phase initializes and begins populating. One thing to note here 
is that in the early setup kernel stub code, we would fail to boot if we 
saw an algorithm we did not support so we would not reach a state where 
we were simply ignoring an active bank as you mentioned in an earlier 
reply. But I also understand your point about limiting the functionality 
to just a subset of algorithms.

Thank you for your feedback,
Ross

