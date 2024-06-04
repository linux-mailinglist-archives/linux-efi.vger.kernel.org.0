Return-Path: <linux-efi+bounces-1130-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EE8BA8FBA8A
	for <lists+linux-efi@lfdr.de>; Tue,  4 Jun 2024 19:34:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 702AE1F27E88
	for <lists+linux-efi@lfdr.de>; Tue,  4 Jun 2024 17:34:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAB7814A09E;
	Tue,  4 Jun 2024 17:34:40 +0000 (UTC)
X-Original-To: linux-efi@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B80751494CB;
	Tue,  4 Jun 2024 17:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717522480; cv=fail; b=ldGnG2ow2qgbiM0OYCeN8ttzFuby/O5xuAuFAn38S2ENGu9/CXdgcItrZABI6YfOBnPfWRiulnR9JMo1aTDEWTJLuXkC9/hr9YYtuLOrOOuyKiyXYt31vInM4zOliJlYBzZEJ2bMG1RXCJp3QSNx79e1RM9ih5uFTTyw3c0NAgk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717522480; c=relaxed/simple;
	bh=y3VdBLuGCJa4+WxgNLZDrBzXPXcvTMII6zboeqxCR1E=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=jLfnVAz6y4NMlpkbzwUGFCp7Qa1aqcD1dmE2pH+FbwKleh8ejr64J1lLwDUXEws/1tKMy99uJQfIERNx8x+ihfUBAZMmTauEovwle8BY6iT25CnLbVGPkvDV1qoV3agBmb5wlwEnb2Uqvc2Y8cwRH/6I2RIFM7WCSYVp0p2jWeE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 454Bn29D013802;
	Tue, 4 Jun 2024 17:34:03 GMT
DKIM-Signature: =?UTF-8?Q?v=3D1;_a=3Drsa-sha256;_c=3Drelaxed/relaxed;_d=3Doracle.com;_h?=
 =?UTF-8?Q?=3Dcc:content-transfer-encoding:content-type:date:from:in-reply?=
 =?UTF-8?Q?-to:message-id:mime-version:references:subject:to;_s=3Dcorp-202?=
 =?UTF-8?Q?3-11-20;_bh=3DiwAAH+yaHWyAcVHtLfsMpkiMznlEaS/of0fT1gFUsnY=3D;_b?=
 =?UTF-8?Q?=3DEW4Q5hE+R/lWO7PSBegVLLQJjpWSlshZtlOhQ4kmM7uKapvsC2O9Oo10nwrw?=
 =?UTF-8?Q?DLamf3Bm_r6aNSuox8dHmck3HDBKsd6zkwbVT/53ycaWI3BT/pdpUhZZdNmbYyV?=
 =?UTF-8?Q?fcIQ1M+gq1OB0A_RrlYAFmE9qh1JMiwupqazVGJO+NATohwTxR+iydDzQAvNE/y?=
 =?UTF-8?Q?7RczMYOifZFDvW0CZtss_DKvNj4CHCYwHuLwVpZE/9zaEnJQYD0M13X78xwzF7p?=
 =?UTF-8?Q?aQ1OneiMk/ofxmJgSuMIiFqEoB_GPmdeZjeQaN69hruVxdxIZZZpCsP4thQIaLU?=
 =?UTF-8?Q?dLGBmYI61yuNTsUmnHNAbWkhviBgEiBY_pA=3D=3D_?=
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3yfuwm5jac-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 04 Jun 2024 17:34:02 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 454HFp7c016446;
	Tue, 4 Jun 2024 17:34:02 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3ygrsaesu0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 04 Jun 2024 17:34:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PlV0CxdGSYQE/j6zRX0mPAERuBG392+9Ra5VDFDQccvfls7tuhXqDcn/NqnvTPotxiUM+8madc9Miioqgsziryof0/VbF/QMbzTfcUQGtVzOtDyyPAECY6gJkYkSvjmbLkvAwLSbsUP0LCJgmxDUoVYZwCBPMa0AJlx/Z5YTcDnGciLe/xoLpacJAzT5G0+XZeBaUJzdIc2tMfpa2a4kDSPMBpBhOK5mTSBKMGUcnBbzdFHj1sHi3l0SGmbcNSWj/desrhkZW9Y2HTTXmI0O4wKY3VYKTFCSYJ8DzhG97jdHJL47yVMx/JuCiYBIrzAlVQETF0PypdCpxNZpmhYIEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iwAAH+yaHWyAcVHtLfsMpkiMznlEaS/of0fT1gFUsnY=;
 b=Dg3uBEzoUjQK3U4QnIFtK8SrocqktsocR4MJXVsfhCCtzWxn11YghpkLLskJu4Pp0QMJD+y1XoLdMDAMORJfsUTVPUFko+HocsHZosYRmSU8o7SIUWaEJ12XlmJI7ao6Rf/RMbvqmkiip+x07k2oNrZcj5LGays/+2l73rxYhaBFRG1+RyJb9CSprAjk1WS7cKI9oGc8VsUb6JOVVQsJxS2WNUaRiN5t+380dqhoSVeZiLqTgP48vwYAcOYMH44rffoD9K6ZknGnrY06uTXw//g/6pGTaAdnNamI+Fr6JNPtU95aXoruZW6pcAEkwaD7LKdWxA2CUoHtowyLqPNs9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iwAAH+yaHWyAcVHtLfsMpkiMznlEaS/of0fT1gFUsnY=;
 b=GjQqbSbFPiZ8j2LJ2YEIlYjMIXLDvy/RP53Rxv3nV/Euf/Ybm57eGVR6juTOLTBklp5dSh/L5XghixnFR8yh/q+AaM0yjMZlWWWais/0aL40NLrYJXDdcZPYU3zs8mSM7JmsX5QihuvgLGQSUb5FZub9R9Zq+Cd4u/rECv0Tyt4=
Received: from DS0PR10MB7224.namprd10.prod.outlook.com (2603:10b6:8:f5::14) by
 MW5PR10MB5825.namprd10.prod.outlook.com (2603:10b6:303:19a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.17; Tue, 4 Jun
 2024 17:33:58 +0000
Received: from DS0PR10MB7224.namprd10.prod.outlook.com
 ([fe80::c57:383f:cfb2:47f8]) by DS0PR10MB7224.namprd10.prod.outlook.com
 ([fe80::c57:383f:cfb2:47f8%6]) with mapi id 15.20.7633.021; Tue, 4 Jun 2024
 17:33:58 +0000
Message-ID: <5b32106b-bb7b-463d-8b0b-589e3d466bf3@oracle.com>
Date: Tue, 4 Jun 2024 10:33:54 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 08/19] x86: Secure Launch kernel early boot stub
To: Ard Biesheuvel <ardb@kernel.org>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-integrity@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-crypto@vger.kernel.org, kexec@lists.infradead.org,
        linux-efi@vger.kernel.org, iommu@lists.linux-foundation.org,
        dpsmith@apertussolutions.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, hpa@zytor.com, dave.hansen@linux.intel.com,
        mjg59@srcf.ucam.org, James.Bottomley@hansenpartnership.com,
        peterhuewe@gmx.de, jarkko@kernel.org, jgg@ziepe.ca,
        luto@amacapital.net, nivedita@alum.mit.edu,
        herbert@gondor.apana.org.au, davem@davemloft.net, corbet@lwn.net,
        ebiederm@xmission.com, dwmw2@infradead.org, baolu.lu@linux.intel.com,
        kanth.ghatraju@oracle.com, andrew.cooper3@citrix.com,
        trenchboot-devel@googlegroups.com, ross.philipson@oracle.com
References: <20240531010331.134441-1-ross.philipson@oracle.com>
 <20240531010331.134441-9-ross.philipson@oracle.com>
 <CAMj1kXHaH6atsvwr6oVPdZuhR5YEXU33-2kYEn6xb1e=gidOCw@mail.gmail.com>
 <CAMj1kXHcYOPTLTh-hEtfHk+JaORGK+fEatTT+UOqLJww+_cNTg@mail.gmail.com>
 <5bffa507-75e8-4cce-ac0c-fe13d6efd3bb@oracle.com>
 <CAMj1kXHLaqyPAw5Jjg91pqFbHoMT2jDqui4rosyerHVudRsq-w@mail.gmail.com>
Content-Language: en-US
From: ross.philipson@oracle.com
In-Reply-To: <CAMj1kXHLaqyPAw5Jjg91pqFbHoMT2jDqui4rosyerHVudRsq-w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR02CA0022.namprd02.prod.outlook.com
 (2603:10b6:a02:ee::35) To DS0PR10MB7224.namprd10.prod.outlook.com
 (2603:10b6:8:f5::14)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7224:EE_|MW5PR10MB5825:EE_
X-MS-Office365-Filtering-Correlation-Id: 5d790ca2-fc61-481f-5051-08dc84bc83a4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|366007|376005|7416005;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?RWFmUXlxTnVhWnZ4MEtYNGIzQWd0N3EyY2pnMXJKeXd3eEhKNGpnVE90NHhE?=
 =?utf-8?B?NFcwQmFmV29CSlNEQzBkQmJ0anFoa0NYeTBwME1DL0pIVWZOdk1UQW9BMDIz?=
 =?utf-8?B?NGNIMmQrd0lBaVBkbTJVU2RWUUpWUW5OUUhoaUowTFNOcXF0cDNYcXZ1eFBZ?=
 =?utf-8?B?dGRGbkRGNDgveFUwZ0U5ZnR1UVJqN1lKNk9GL3I3Qm5UOXQwNCtaN1NDUVdC?=
 =?utf-8?B?K3F6OUllRi9aUE1xcFhDdDRmaFNEZEZBQ0tQbHA4WlhwN01EV296Nng4UkNR?=
 =?utf-8?B?dXR3UXRQVEE4a2VzaFl4K3BvRldSb0dmbEhhV3JKU2dSaUVUUXc0akZFUXZC?=
 =?utf-8?B?ejliYUhFYkZEcXRuUnpNZWFBS05oeVR3anVTQ2hhZkovWldvUXAyWkl4WDRt?=
 =?utf-8?B?UHRleExWQTdhMFFjdXdZbFVmVHJLR3hxbktyTlA1bm9IMzBRRlRQVjdiVEZy?=
 =?utf-8?B?Q0ovZGhjN0lzWndYYS96Y1FVVm1NRzNCTHhZSWxsUWIxTlBOZ09pQitiYUI2?=
 =?utf-8?B?WjQyQmh4Z2VvUHhFbXB3WWI1ME1LSnZDamxMc3lwemFsT2NUbUs1S3hJYTBE?=
 =?utf-8?B?RTdaWTlmNS9RbE1YRk02UEhaUDdyZ2dqd2ZtVU9SbXo1VDk4eUwvMDhYbWo1?=
 =?utf-8?B?MXBxa3RuWHF0ZHNKZklqamVtQmFvakhCbHl6UEFWcVoxeVBmeTJvMzZwYjA0?=
 =?utf-8?B?a0R0WnhHRDkxcVliMGNzcmdkbDA0T1I2dmVTRUJzOUU4UUQ0Zk5HYUhLT3Nl?=
 =?utf-8?B?SnBSQVpGVVhoZDM5Z3hibHJ0NTRVVThmTjZ6REdhM3hBUjZva0xaV3BNZk9j?=
 =?utf-8?B?Qk1XMFQ2WXdSd2hldmZFYXdFMTF3dmRDN1JJK1M5ZWVzL250NWFIWnRtaDhy?=
 =?utf-8?B?S09nUUV1eW01Y3gzVXlCUGMxWVhreS83NjRPZ2FQM2d5SjhSelhUVURCbUp5?=
 =?utf-8?B?RUZwckQxN3hEWUZ5M2JxcHpuQmRHY3l2TTlxU2Jjd3B6cUpocnE2dlB0c0M4?=
 =?utf-8?B?U05aU01kL3UzYWJTUFVDQVBTZm52WVpsWkNFTXNqZ1cyb0NhSm5qVTBZaCs4?=
 =?utf-8?B?WFZoaGp2ZE8rWXZ0VjVjdElOVi8vYXpMcVN6OUJTSEY4N0M2aGhBbjNlSDBy?=
 =?utf-8?B?QkNiUG9kVHJvb1M1TE5VVVVhcjBFclRta1FBbFhsRjk5MkEyMHRUNFNyMDZ1?=
 =?utf-8?B?LzBvUU80YjhxU1BoN0pZRnlybzh3K2NqaXhmdy9rYmJoRlo5Y0p0TXJsaXZE?=
 =?utf-8?B?eHIyQlNBMFpkM3ArNHlUWVp5U1laL1p6ZS9zRnpGUHVGaktGWWF2U21UeFRD?=
 =?utf-8?B?U09DaTlCTkpJVDFRSlpralRPdjhIVm51VzBmL0liN1JHaUQxaGhZdStuRXdH?=
 =?utf-8?B?dnNUTUZHZ1huU0Rzd2hMNTFTaFp5Slg1S3BGRlJ6eWl1QXlPTllnUEY4OWdh?=
 =?utf-8?B?UDBCSnNJQklSTlBhUUl3TnBWRXJYbGdtOFNTUzM2SldDMzhjZlo5TjRlM2Zo?=
 =?utf-8?B?ZnNQRzZyTkZKT1RKTWpyRnRmaEFoS2hPVnlxNlJkZVc0UmE5QXZEY2w0am5m?=
 =?utf-8?B?YTdHQUJnRUErbjRvd1FLRjMvUUxqWnArQ3dnWFJrQWtzYU5ZcnpZMk1DNGVj?=
 =?utf-8?B?MTd5OUd2YUdVTERRYTBXbG8wRTd5Z0V1NlpkT2RFZ2pueUl1emdsVmZCSGpR?=
 =?utf-8?B?MTBrZVFkblBmRVFhNVhXTFhrKzl3ZGlKaFU4bkd5SmVNK2hldDc5ZVpnPT0=?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7224.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005)(7416005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?L0xzSkJsQXNsV2FPZHJEVG5GOFRnNHIrWlIyR1BIMmk5QnlVVDNSQkZNdnBu?=
 =?utf-8?B?dVVydXduRDlpanhwL0pzK1B0a0w0YUNBZWQ0WllRS3FZT1daVm5VaHZFUTcx?=
 =?utf-8?B?UU43NmVOYy9aRGFYK0tpZWJtRHN6SFNEMkZCZ3lTSE1OUzNBM0xVRVcwZkgr?=
 =?utf-8?B?bEpzRlFQc2E4aFBneGlrciswYzZENFpRZ1lkOWhoeUNOOHJOYlNXd3dCZXhk?=
 =?utf-8?B?Wk5xTmk4a3psSWxwdHpYMXU4Z1Bjb2grS1lwdWxFVkYxSkZnREVmV2F5YkZD?=
 =?utf-8?B?UGd1MEM0NGovOGpOYkZmWVd4TDc0ZTJOYTE4ZEpSMWJ2NnhvZjI0ajEyNndt?=
 =?utf-8?B?dFVjcTZienVlZkhTN09sTmpaWWpSTWVGVkk5TTN3R2lYTWFSV3BOc3dqakNx?=
 =?utf-8?B?dXhhcktkR3NlREgvR01nZzF5MUxnUEVlSUgwNmdmQXRtUXA5M1hvZkR0eFlO?=
 =?utf-8?B?MVZGZ1cxTlorV05MNm93c1R6b1lRYWZYaVgrWjg5SkZsMzE4Qk00RzlKZFFm?=
 =?utf-8?B?Z0lIUTJ5eFg5MzREaFBMcUxmM3hYVXNET0ZxaEtROUxmT3IrY2lGMGo2UERk?=
 =?utf-8?B?R1dJbmx0NEFBZmg0NGxhdkV0U0laRzFUb2hzdzQyRWE0Qjg1V29IdzVPNGVy?=
 =?utf-8?B?RWxNK2FCd0xRZjFWR1ZsR3RXOEVOVmRlbWpVVEFUMzZrLzJMQWtPQXpkenhR?=
 =?utf-8?B?elZZU1JPdzlmRXZOZytMRW1qWlZvclJMMEhtWWpnVVdIdFBrK3kxelRHbTRy?=
 =?utf-8?B?QUhCYjBqVEpjcHU2Y1NjcmpjcUp5bW4vTkVlcktJVExuTVoxVTlRSFo4THVz?=
 =?utf-8?B?clovVFFiR2c3eUtNVEJRUDZ0ZlpiaHNSbUNzb3RPaEtGbnlFcHV2VU5nOXlk?=
 =?utf-8?B?NFA3RnMrK1NkaElpQ2Nlc3Z3OXpDbnhvTStibWNjN2F2bmYwNjZpbW9CVmVY?=
 =?utf-8?B?Sm93L0dkMS94c2FQZ0NRdkRHYkxIOFp6M0FybHRnbStOVVF3T1F6eXo1OENi?=
 =?utf-8?B?M0dSYW9LYVFBc2tiRThOcjd3NTFWTnpVSXlxSTRYNEo4ZTdQRlhFWDdITWMy?=
 =?utf-8?B?L3JkTVB5UHUrc3Z2emV2Z2lqRHNzeEplOEF5THhuTmVNbG8yc0hIUEZBeHdI?=
 =?utf-8?B?bGsxU2JuNUVuYlkwZFMyQkl0d1FUUjA1WDBzOHI2V3FEYkpGeDFSbTlhK3lO?=
 =?utf-8?B?K3RFbmxDb0hFakFmNndGTmNmRmpEWW14T2FMeXlFYlk3a0VEQ2RTdEExWFhV?=
 =?utf-8?B?NjJvNnM2TEdGZ2d6cUZJSHZEVUlwb0x1VG1ZZ3hlMm03bmRxK1Y3eHEvbDY0?=
 =?utf-8?B?WnNKWHJPOU1aRmkxblBxTGJRY0N5bGlZU0FQOHI4UmF6elJYaUJEckdkWm5V?=
 =?utf-8?B?WitoS1JSNkhQbkREN05UWEp3eEJnOUZkc1V4MVBlOHVTbHFmcXp4ZkJ4RTEr?=
 =?utf-8?B?ajB4UFhKYVVYaXIzNVZUSnh1OElZZ1dTU0hkaDNTdlpNdXJKUGcxdXZpeDZU?=
 =?utf-8?B?aHY3cytlRlRYMFB3ZW53bVJFZGNENEFJSnJPY3FBeEtRRnVxVXhOV3VOWjFh?=
 =?utf-8?B?aDBpbUFUbGtIQmRIY1FRV2FnNFdsdVJBS214bHh2cUVGSGtaeFFzQkwwVTJw?=
 =?utf-8?B?dC9sbTNQenZlR0xhclRmNVVCZzA2VkRDN3laRkZTK2hlQTFYMzFMZmtaMW1T?=
 =?utf-8?B?OFFtSlcxcWM0dUxmYWFLK2F0dFpDMkw5L2ROSU43bTk3QWpUZnE4UnBnS2VB?=
 =?utf-8?B?Mlg0M1JFOWUyeXprNmZxREkvTjFUdzhJWVFDeUJqSUdqOE5aOElqaldyTEMy?=
 =?utf-8?B?M0hqMWgrZWZyTzcrT01ZcFNMdmZSV0d6ZjhBT2FobHI0TUowZ0VuYkJrT0hL?=
 =?utf-8?B?UngzemlJUW1EdXBMQnozZVNWcS9LQ1lSSjNtVUZWNnV2a0ZkUFJXS3c2U1Bh?=
 =?utf-8?B?V1VTdzFOMEVoeE9taHNNUTV0MzdrRCtIaHVDOHk5SEhLMVhIUW0rWEM0WlFZ?=
 =?utf-8?B?eFF4WDYrTDh6NGVrYzMzUzEvVEFQZ2pFUWtMcjBkNkpxNE5aWkNKMlVMTU5k?=
 =?utf-8?B?aWphUFBuL2YwLzYyNGdRdmlIZWR4YW1jT1Rsdmx1MUtNMHFkcnJobTcrWjVM?=
 =?utf-8?B?M1hmWWpRcFo4bFZjWFpQbEloYVpEVTUxL2k2SjN4OVdzZm9TbHhjM05MWDZr?=
 =?utf-8?B?Q1E9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	Sk3dzT8EFojTuSk7rfaArHH4ad+UPpsQiUr8swz5EK/ybpvFzkodzQcSUhAgxhjzCnV8lCyW2UzW582zBVx8v2EyRbIpmI4wm31g/Rc91G0kbBRrJHfp/tNYMbhB+Qe7SqRIBeImpjDMx8ABAjrFpvWfF4s3FZk7UmWjbyGhbntnvm1lQ7nJF3GutG8wPZS2+WXcsOoCoSNO5YRr9JF0o2SG+C4hGcQ/B4bLfEUkGr3Pi89rqATP+fY8OYQnFPt4uaf+OXnsRTQAjgRMOHupZ/Owx7WxxkRZO29dNTRoI2XHrcTfK+rG7cyjmEcY/6TNat3FU2gdNEVyS3BSZom9uZZxtW+CN5+WGAGpIN7KBI2rt8Ggewr14EKmCkHWGNWjcpbXC7LpCVNx9xO9cT7+juEO6QzsFv1Ajme4LBc9hjvQaLNooXBjGo3Jz9paQZidEZicWRvwMd2r4bR8Xe/o3EvbsDrYjgQgFmbunsaWjfaC252GqJ7GWABRxc2GPjxjqtx1te/9n6hYbfymbxNlsZpeK545RfHqZBPCuZkRMkTvGXPhsUXT30SbcOmAobY0aIWLEPX6IChXraepgnTTpTFPsPTQWLqtMDVKmzjqQSA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d790ca2-fc61-481f-5051-08dc84bc83a4
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7224.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2024 17:33:57.8598
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AFi2ySnDs9URxEP1TlEenz2JixeEM2ExvF7FaIzZLxxZyO3U4qT5xn6Oy4Yvyf69a3Sf1BKWqxqhTCIB/fuvuAkCbGWHkbidfwRuCNX0uMg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR10MB5825
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-04_09,2024-06-04_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 spamscore=0
 malwarescore=0 suspectscore=0 phishscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2405010000
 definitions=main-2406040141
X-Proofpoint-GUID: 2jeY6i5kTd45XkiGhbifNwZU3zfTi2Ih
X-Proofpoint-ORIG-GUID: 2jeY6i5kTd45XkiGhbifNwZU3zfTi2Ih

On 6/4/24 10:27 AM, Ard Biesheuvel wrote:
> On Tue, 4 Jun 2024 at 19:24, <ross.philipson@oracle.com> wrote:
>>
>> On 5/31/24 6:33 AM, Ard Biesheuvel wrote:
>>> On Fri, 31 May 2024 at 13:00, Ard Biesheuvel <ardb@kernel.org> wrote:
>>>>
>>>> Hello Ross,
>>>>
>>>> On Fri, 31 May 2024 at 03:32, Ross Philipson <ross.philipson@oracle.com> wrote:
>>>>>
>>>>> The Secure Launch (SL) stub provides the entry point for Intel TXT (and
>>>>> later AMD SKINIT) to vector to during the late launch. The symbol
>>>>> sl_stub_entry is that entry point and its offset into the kernel is
>>>>> conveyed to the launching code using the MLE (Measured Launch
>>>>> Environment) header in the structure named mle_header. The offset of the
>>>>> MLE header is set in the kernel_info. The routine sl_stub contains the
>>>>> very early late launch setup code responsible for setting up the basic
>>>>> environment to allow the normal kernel startup_32 code to proceed. It is
>>>>> also responsible for properly waking and handling the APs on Intel
>>>>> platforms. The routine sl_main which runs after entering 64b mode is
>>>>> responsible for measuring configuration and module information before
>>>>> it is used like the boot params, the kernel command line, the TXT heap,
>>>>> an external initramfs, etc.
>>>>>
>>>>> Signed-off-by: Ross Philipson <ross.philipson@oracle.com>
>>>>> ---
>>>>>    Documentation/arch/x86/boot.rst        |  21 +
>>>>>    arch/x86/boot/compressed/Makefile      |   3 +-
>>>>>    arch/x86/boot/compressed/head_64.S     |  30 +
>>>>>    arch/x86/boot/compressed/kernel_info.S |  34 ++
>>>>>    arch/x86/boot/compressed/sl_main.c     | 577 ++++++++++++++++++++
>>>>>    arch/x86/boot/compressed/sl_stub.S     | 725 +++++++++++++++++++++++++
>>>>>    arch/x86/include/asm/msr-index.h       |   5 +
>>>>>    arch/x86/include/uapi/asm/bootparam.h  |   1 +
>>>>>    arch/x86/kernel/asm-offsets.c          |  20 +
>>>>>    9 files changed, 1415 insertions(+), 1 deletion(-)
>>>>>    create mode 100644 arch/x86/boot/compressed/sl_main.c
>>>>>    create mode 100644 arch/x86/boot/compressed/sl_stub.S
>>>>>
>>>>> diff --git a/Documentation/arch/x86/boot.rst b/Documentation/arch/x86/boot.rst
>>>>> index 4fd492cb4970..295cdf9bcbdb 100644
>>>>> --- a/Documentation/arch/x86/boot.rst
>>>>> +++ b/Documentation/arch/x86/boot.rst
>>>>> @@ -482,6 +482,14 @@ Protocol:  2.00+
>>>>>               - If 1, KASLR enabled.
>>>>>               - If 0, KASLR disabled.
>>>>>
>>>>> +  Bit 2 (kernel internal): SLAUNCH_FLAG
>>>>> +
>>>>> +       - Used internally by the setup kernel to communicate
>>>>> +         Secure Launch status to kernel proper.
>>>>> +
>>>>> +           - If 1, Secure Launch enabled.
>>>>> +           - If 0, Secure Launch disabled.
>>>>> +
>>>>>      Bit 5 (write): QUIET_FLAG
>>>>>
>>>>>           - If 0, print early messages.
>>>>> @@ -1028,6 +1036,19 @@ Offset/size:     0x000c/4
>>>>>
>>>>>      This field contains maximal allowed type for setup_data and setup_indirect structs.
>>>>>
>>>>> +============   =================
>>>>> +Field name:    mle_header_offset
>>>>> +Offset/size:   0x0010/4
>>>>> +============   =================
>>>>> +
>>>>> +  This field contains the offset to the Secure Launch Measured Launch Environment
>>>>> +  (MLE) header. This offset is used to locate information needed during a secure
>>>>> +  late launch using Intel TXT. If the offset is zero, the kernel does not have
>>>>> +  Secure Launch capabilities. The MLE entry point is called from TXT on the BSP
>>>>> +  following a success measured launch. The specific state of the processors is
>>>>> +  outlined in the TXT Software Development Guide, the latest can be found here:
>>>>> +  https://urldefense.com/v3/__https://www.intel.com/content/dam/www/public/us/en/documents/guides/intel-txt-software-development-guide.pdf__;!!ACWV5N9M2RV99hQ!Mng0gnPhOYZ8D02t1rYwQfY6U3uWaypJyd1T2rsWz3QNHr9GhIZ9ANB_-cgPExxX0e0KmCpda-3VX8Fj$
>>>>> +
>>>>>
>>>>
>>>> Could we just repaint this field as the offset relative to the start
>>>> of kernel_info rather than relative to the start of the image? That
>>>> way, there is no need for patch #1, and given that the consumer of
>>>> this field accesses it via kernel_info, I wouldn't expect any issues
>>>> in applying this offset to obtain the actual address.
>>>>
>>>>
>>>>>    The Image Checksum
>>>>>    ==================
>>>>> diff --git a/arch/x86/boot/compressed/Makefile b/arch/x86/boot/compressed/Makefile
>>>>> index 9189a0e28686..9076a248d4b4 100644
>>>>> --- a/arch/x86/boot/compressed/Makefile
>>>>> +++ b/arch/x86/boot/compressed/Makefile
>>>>> @@ -118,7 +118,8 @@ vmlinux-objs-$(CONFIG_EFI) += $(obj)/efi.o
>>>>>    vmlinux-objs-$(CONFIG_EFI_MIXED) += $(obj)/efi_mixed.o
>>>>>    vmlinux-objs-$(CONFIG_EFI_STUB) += $(objtree)/drivers/firmware/efi/libstub/lib.a
>>>>>
>>>>> -vmlinux-objs-$(CONFIG_SECURE_LAUNCH) += $(obj)/early_sha1.o $(obj)/early_sha256.o
>>>>> +vmlinux-objs-$(CONFIG_SECURE_LAUNCH) += $(obj)/early_sha1.o $(obj)/early_sha256.o \
>>>>> +       $(obj)/sl_main.o $(obj)/sl_stub.o
>>>>>
>>>>>    $(obj)/vmlinux: $(vmlinux-objs-y) FORCE
>>>>>           $(call if_changed,ld)
>>>>> diff --git a/arch/x86/boot/compressed/head_64.S b/arch/x86/boot/compressed/head_64.S
>>>>> index 1dcb794c5479..803c9e2e6d85 100644
>>>>> --- a/arch/x86/boot/compressed/head_64.S
>>>>> +++ b/arch/x86/boot/compressed/head_64.S
>>>>> @@ -420,6 +420,13 @@ SYM_CODE_START(startup_64)
>>>>>           pushq   $0
>>>>>           popfq
>>>>>
>>>>> +#ifdef CONFIG_SECURE_LAUNCH
>>>>> +       /* Ensure the relocation region is coverd by a PMR */
>>>>
>>>> covered
>>>>
>>>>> +       movq    %rbx, %rdi
>>>>> +       movl    $(_bss - startup_32), %esi
>>>>> +       callq   sl_check_region
>>>>> +#endif
>>>>> +
>>>>>    /*
>>>>>     * Copy the compressed kernel to the end of our buffer
>>>>>     * where decompression in place becomes safe.
>>>>> @@ -462,6 +469,29 @@ SYM_FUNC_START_LOCAL_NOALIGN(.Lrelocated)
>>>>>           shrq    $3, %rcx
>>>>>           rep     stosq
>>>>>
>>>>> +#ifdef CONFIG_SECURE_LAUNCH
>>>>> +       /*
>>>>> +        * Have to do the final early sl stub work in 64b area.
>>>>> +        *
>>>>> +        * *********** NOTE ***********
>>>>> +        *
>>>>> +        * Several boot params get used before we get a chance to measure
>>>>> +        * them in this call. This is a known issue and we currently don't
>>>>> +        * have a solution. The scratch field doesn't matter. There is no
>>>>> +        * obvious way to do anything about the use of kernel_alignment or
>>>>> +        * init_size though these seem low risk with all the PMR and overlap
>>>>> +        * checks in place.
>>>>> +        */
>>>>> +       movq    %r15, %rdi
>>>>> +       callq   sl_main
>>>>> +
>>>>> +       /* Ensure the decompression location is covered by a PMR */
>>>>> +       movq    %rbp, %rdi
>>>>> +       movq    output_len(%rip), %rsi
>>>>> +       callq   sl_check_region
>>>>> +#endif
>>>>> +
>>>>> +       pushq   %rsi
>>>>
>>>> This looks like a rebase error.
>>>>
>>>>>           call    load_stage2_idt
>>>>>
>>>>>           /* Pass boot_params to initialize_identity_maps() */
>>>>> diff --git a/arch/x86/boot/compressed/kernel_info.S b/arch/x86/boot/compressed/kernel_info.S
>>>>> index c18f07181dd5..e199b87764e9 100644
>>>>> --- a/arch/x86/boot/compressed/kernel_info.S
>>>>> +++ b/arch/x86/boot/compressed/kernel_info.S
>>>>> @@ -28,6 +28,40 @@ SYM_DATA_START(kernel_info)
>>>>>           /* Maximal allowed type for setup_data and setup_indirect structs. */
>>>>>           .long   SETUP_TYPE_MAX
>>>>>
>>>>> +       /* Offset to the MLE header structure */
>>>>> +#if IS_ENABLED(CONFIG_SECURE_LAUNCH)
>>>>> +       .long   rva(mle_header)
>>>>
>>>> ... so this could just be mle_header - kernel_info, and the consumer
>>>> can do the math instead.
>>>>
>>>>> +#else
>>>>> +       .long   0
>>>>> +#endif
>>>>> +
>>>>>    kernel_info_var_len_data:
>>>>>           /* Empty for time being... */
>>>>>    SYM_DATA_END_LABEL(kernel_info, SYM_L_LOCAL, kernel_info_end)
>>>>> +
>>>>> +#if IS_ENABLED(CONFIG_SECURE_LAUNCH)
>>>>> +       /*
>>>>> +        * The MLE Header per the TXT Specification, section 2.1
>>>>> +        * MLE capabilities, see table 4. Capabilities set:
>>>>> +        * bit 0: Support for GETSEC[WAKEUP] for RLP wakeup
>>>>> +        * bit 1: Support for RLP wakeup using MONITOR address
>>>>> +        * bit 2: The ECX register will contain the pointer to the MLE page table
>>>>> +        * bit 5: TPM 1.2 family: Details/authorities PCR usage support
>>>>> +        * bit 9: Supported format of TPM 2.0 event log - TCG compliant
>>>>> +        */
>>>>> +SYM_DATA_START(mle_header)
>>>>> +       .long   0x9082ac5a  /* UUID0 */
>>>>> +       .long   0x74a7476f  /* UUID1 */
>>>>> +       .long   0xa2555c0f  /* UUID2 */
>>>>> +       .long   0x42b651cb  /* UUID3 */
>>>>> +       .long   0x00000034  /* MLE header size */
>>>>> +       .long   0x00020002  /* MLE version 2.2 */
>>>>> +       .long   rva(sl_stub_entry) /* Linear entry point of MLE (virt. address) */
>>>>
>>>> and these should perhaps be relative to mle_header?
>>>>
>>>>> +       .long   0x00000000  /* First valid page of MLE */
>>>>> +       .long   0x00000000  /* Offset within binary of first byte of MLE */
>>>>> +       .long   rva(_edata) /* Offset within binary of last byte + 1 of MLE */
>>>>
>>>> and here
>>>>
>>>
>>> Ugh never mind - these are specified externally.
>>
>> Can you clarify your follow on comment here?
>>
> 
> I noticed that -as you pointed out in your previous reply- these
> fields cannot be repainted at will, as they are defined by an external
> specification.
> 
> I'll play a bit more with this code tomorrow - I would *really* like
> to avoid the need for patch #1, as it adds another constraint on how
> we construct the boot image, and this is already riddled with legacy
> and other complications.

Yea I should have read forward through all your replies before 
responding to the first one but I think it clarified things as you point 
out here. We appreciate you help and suggestions.

Ross

