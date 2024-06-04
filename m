Return-Path: <linux-efi+bounces-1146-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C3A3E8FBD53
	for <lists+linux-efi@lfdr.de>; Tue,  4 Jun 2024 22:29:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 37E0CB213A1
	for <lists+linux-efi@lfdr.de>; Tue,  4 Jun 2024 20:29:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A57E514B954;
	Tue,  4 Jun 2024 20:29:34 +0000 (UTC)
X-Original-To: linux-efi@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB78B14B945;
	Tue,  4 Jun 2024 20:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717532974; cv=fail; b=SksqOPYUZt7ncXPzAAa+U1Wwmnn2rm4oZ/FaXKWUq/3OOQn+g1AipzZ9J+OOM9LOiJTuKyurs/0VM/ei95XwUolCxKdGUGGQIouGoa33m6eHXeDI2NE9xQpfS3IACzcvsx+cURuRrptP6nwym7dZOIwWhjlbzhqhYK4UfualrlA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717532974; c=relaxed/simple;
	bh=CPrRFXiFAuMTaI+d1NKd0shr1KzqnMnUf8Db6dD5lSA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ENsMsM74s92T4nuxkLqVcAlnn33FKXtxfVco8AWYPeUpgpisUHdYW7GjxiQMLO9gX6GecTUdh4caspDxKJ+qycOFRT0B0nnJ62WZn4fLLldjQwsSi6mi63rKzt/lMBlD/po/kmXKkv6ebgrOAMNJ1VvyPIJz0H5aA6b9M2TlJc4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 454JKlGR032335;
	Tue, 4 Jun 2024 20:28:51 GMT
DKIM-Signature: =?UTF-8?Q?v=3D1;_a=3Drsa-sha256;_c=3Drelaxed/relaxed;_d=3Doracle.com;_h?=
 =?UTF-8?Q?=3Dcc:content-transfer-encoding:content-type:date:from:in-reply?=
 =?UTF-8?Q?-to:message-id:mime-version:references:subject:to;_s=3Dcorp-202?=
 =?UTF-8?Q?3-11-20;_bh=3DUb3Ly+U0zQJP/rT/NiMGCBHSoUOgqN+LnGpaWkwmiMg=3D;_b?=
 =?UTF-8?Q?=3DHqeHICfdx+2lCpGM0uS00abhZv6mFZ3fy850rTvE/yzskB7tWgxnPVn4eR3C?=
 =?UTF-8?Q?gEz9D4Um_38mzfuK9shLgZzhrqzVpTJum8qcbOTDR0m/7ip3Usyn56yOPYCMI4V?=
 =?UTF-8?Q?tnL2KfmVlLgcPz_2XaHyLWbHnEVZWcVvDpTwh/ySwYB9xKmg/28hcCJq5NKKgfk?=
 =?UTF-8?Q?eTsRa/ZC0vyzi+ciMvH/_6OjQAJ6R+FusyFtgO/GPX4BbWJE0qqghf9c3ghRJ4L?=
 =?UTF-8?Q?Z/rE8cikXscAK6b0701whoh3IA_Sl7lks/dARzrdzSaXKD7LffwrGCYim13whQp?=
 =?UTF-8?Q?H8NuhJ8R+r2aEGcP+kvY7fYZut8gkHgh_6w=3D=3D_?=
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3yfuyu5uxw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 04 Jun 2024 20:28:50 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 454JPWSV025263;
	Tue, 4 Jun 2024 20:28:40 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2041.outbound.protection.outlook.com [104.47.66.41])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3ygrt94n6j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 04 Jun 2024 20:28:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zg9N/MEdazA2yB4RNZBf7bSZ96+2BXdRkTQSy/75bf58sbuYE4CCAGmgOs0/eOznYdlzdk5KTEwlD9bAlzyJFWo+kpquV7AyDBY8VYfGW5P2JMq7t4hWgIOiDXqLIXNf+1tTLwV/RAZJNsFYbRErF1QoUtx2nAxCoUiqjyayXet3I/s3MjxNzr1NYbqOm5UA2QTQymdhCAHCSOQUWStxJeCIbw4M4Z2VCwW4FA1wJJ0tobDmGWzopBQbvlTJiDmF5EvsB5kvoW3Lxbs+ZqpB0YrwCcFgk1BLoFiTl1wDAJFqtna2/mQjG1zqg4TMiNJol9FxMVLd5NWLMGQR+vtcUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ub3Ly+U0zQJP/rT/NiMGCBHSoUOgqN+LnGpaWkwmiMg=;
 b=EzeJNlRdiM0BedhGL/duCa7yCtZd+SpeRurAe0HLiagvVYNaj/neVjSfTDat8tC6ZuAR6ubK2NefsoZbZXpputLGmSQ9cWiJ6D64S4sZUMlAGpniYVDVRLLsG3nQuXOlJdQVAVWby7q4y/lDXrgZML3O4cZsgiGtppWoIB4ncs0SMKDgdWcJo3ehLxyqJ6waHU0YMJZwFH6oI2LxtVZBJbF8LnoH26KiOqp8QaUOH6Z7ikbqaprgLKyN0lo3OHdU8i8Jthq2DdYXaXTAbF+/+y1Sb5Rf3hXeMVnwJqk+nZbwt2WFfz8zVPP1KCYxvyXgfR83chMf3aBhhR7AoHZBPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ub3Ly+U0zQJP/rT/NiMGCBHSoUOgqN+LnGpaWkwmiMg=;
 b=NK+y770lOgYaIfr3Gy5sTRBPrl5FZWhd+0UoWyROjmIDIE9j5v23BA8hY9T4ytVfSa/DdLir/stWuaaEjgDSmm7RQoPUgVAluwCVPq9sp/X6CgCExuS7tWQLPUiwxAVJhVPjuyOd6+sID6KvcJLNiJH8QtKOcxX9DFm76OiK4r0=
Received: from DS0PR10MB7224.namprd10.prod.outlook.com (2603:10b6:8:f5::14) by
 CO1PR10MB4563.namprd10.prod.outlook.com (2603:10b6:303:92::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7633.27; Tue, 4 Jun 2024 20:28:37 +0000
Received: from DS0PR10MB7224.namprd10.prod.outlook.com
 ([fe80::c57:383f:cfb2:47f8]) by DS0PR10MB7224.namprd10.prod.outlook.com
 ([fe80::c57:383f:cfb2:47f8%6]) with mapi id 15.20.7633.021; Tue, 4 Jun 2024
 20:28:37 +0000
Message-ID: <edbf18ba-d3d4-4dc1-a6e4-e8b7f2b0a05a@oracle.com>
Date: Tue, 4 Jun 2024 13:28:33 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 01/19] x86/boot: Place kernel_info at a fixed offset
To: Jarkko Sakkinen <jarkko@kernel.org>, linux-kernel@vger.kernel.org,
        x86@kernel.org, linux-integrity@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-crypto@vger.kernel.org,
        kexec@lists.infradead.org, linux-efi@vger.kernel.org,
        iommu@lists.linux-foundation.org
Cc: dpsmith@apertussolutions.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, hpa@zytor.com, dave.hansen@linux.intel.com,
        ardb@kernel.org, mjg59@srcf.ucam.org,
        James.Bottomley@hansenpartnership.com, peterhuewe@gmx.de, jgg@ziepe.ca,
        luto@amacapital.net, nivedita@alum.mit.edu,
        herbert@gondor.apana.org.au, davem@davemloft.net, corbet@lwn.net,
        ebiederm@xmission.com, dwmw2@infradead.org, baolu.lu@linux.intel.com,
        kanth.ghatraju@oracle.com, andrew.cooper3@citrix.com,
        trenchboot-devel@googlegroups.com, ross.philipson@oracle.com
References: <20240531010331.134441-1-ross.philipson@oracle.com>
 <20240531010331.134441-2-ross.philipson@oracle.com>
 <D1RFUDSAJJKJ.2MF9OSQAJGBRW@kernel.org>
Content-Language: en-US
From: ross.philipson@oracle.com
In-Reply-To: <D1RFUDSAJJKJ.2MF9OSQAJGBRW@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR07CA0098.namprd07.prod.outlook.com
 (2603:10b6:a03:12b::39) To DS0PR10MB7224.namprd10.prod.outlook.com
 (2603:10b6:8:f5::14)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7224:EE_|CO1PR10MB4563:EE_
X-MS-Office365-Filtering-Correlation-Id: 815c0c52-8540-40b6-e7cb-08dc84d4e9e0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|7416005|1800799015|376005|366007;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?UDBnL3JrRU9vZjZBT0c2WXBuYjQrcU52SXBHQVZGMDRWZU5qRzJLeVJoTGNU?=
 =?utf-8?B?WDhCay9iSGN0M3hzL0UrOHEzTVhKLytBTHQ0NHV4RC83ZUtRTVFBR01GU1Jo?=
 =?utf-8?B?aXp2YktNZEpQeGVFWDZCZEFnRWJYZEtJVDVteDVDK294R0orWEtFcnp1WjRa?=
 =?utf-8?B?U2VGaXBobzE5QWlNbHh0THJkMitZaDkybHljdDRPSHRsSEdYWnU5cmpHTGhn?=
 =?utf-8?B?dEp3cnBKUDZpQ1lyZTduazVhdXd3Z0pKdnRxc3Z1Y0RwTGFDaUhtNllCY2lt?=
 =?utf-8?B?anFUdDdobXZ4TlM1cExVZ3BFUVIyYUUyT3pyWVI1QXBnb3pMNTdFbWUrcm1a?=
 =?utf-8?B?SGV0MGJnU0tkazVyK1Y3MHU3SG1zaDM0bUhtSWhtZFp5S2dVN0EyT2hJOGlQ?=
 =?utf-8?B?b3BSaXAweVd3WUF4aTdzYnhzWTF4ZjNnbmhRdVNLNTBPVWNIcURSMWJmcFcr?=
 =?utf-8?B?UEVaeWpkRnk0dE8wSTlETnBleXRrSUhHc1VMNFhFdjZTUEVzUkUwOWxOcWs3?=
 =?utf-8?B?Mmt4SmlacEladkQ2dW9jdDVyd3VxbVovQ0dEOGZuQlFSVk44OFFwR3NMd2Iz?=
 =?utf-8?B?U2pHTEU4QnpnSDNyWDExMnNFY2dzUzYvTlNBRkxmb1p5SkJkREJLZXQ0Y2xw?=
 =?utf-8?B?bk5UV3ZrSXBKSUF3aldUbFFrSEVuWXQ3c1VXN2hwYmRWVUhYL3dYSURuZmJO?=
 =?utf-8?B?T1Z3UWZwL1dKTzFNaFl5SCsreHBTNFZETVBwdHVITW1PS3QrM2grME5DSm45?=
 =?utf-8?B?cHFGY0YzUWVNemI5TTVlaXg0OHZtOHVxQlNIdmZxQnlOVnpTelczVU1FSlQ1?=
 =?utf-8?B?SjU1ekxtdGoyZmplWkFkNXp4OFlMZE1YTHY1UXdMTmtZYSs4aytCTjRrem1n?=
 =?utf-8?B?cjNod2JyRkg4L2JIRUFvc1lqWHVobWpGbE8wSkNSL1dsTXhxOGlKWDNWZEdD?=
 =?utf-8?B?MXJwY3RjUDUrT2RXeGFQb3hJZUQ5ZFEvR1hvSEF5SVB0eVR6aSt2VXNzd09z?=
 =?utf-8?B?bkI1OU9RMmpJME9WYTlPNnFrNmM0L2hVbTB3Qk1jdGtLbWE3dGU3alA0UjdR?=
 =?utf-8?B?RjRaQ3NMdFhDdU83Q3BPbUZBblZTTU41SnhlN0ZIdFBiRzVZY0t6Q1lNN1Mz?=
 =?utf-8?B?ZHFjbUNnTW5HUzBid0lsRzZrUkZrZzYwZGJhTXR4NTB2ZzFPNXRQZ3dKWk1C?=
 =?utf-8?B?M2lJUDQzQUcxTG1GMGlLQ2pwU01vdE1sNklWaDl4ZHhuZEEwOUhZYU12Y3h2?=
 =?utf-8?B?MlFMand0emdUUzVxcTNQRG9peUZ1RTByVjNFMnJoaFQwa0NDL2M4WDZTWHVC?=
 =?utf-8?B?M2xJK0RiRU9KdjJtUytRODg2Z0NDR3RKblYvVE1YVjMyVTNIVHV4cUYxaVdu?=
 =?utf-8?B?ZGNoN2d2S1pZbjhpM1pjSDk3UFo0MkJQeDNuaktzWHlaekJUY0tPSDZuVDhW?=
 =?utf-8?B?aG15SWRMR2dWamJKNEhzYXZZcklQMlVnSGhvU05leTkwUFJWYis3cnNsTTlw?=
 =?utf-8?B?Wm1mRHh0R0xZWVZPTEFlY3V3SWxhTHlVNVlYeWQ3cW9ld0U0SFg2djY4Unky?=
 =?utf-8?B?WUZoZWtKeHU0bk01RzI4MEdPQUhzNnZPTFVjK1gxOURsVkVnK0ZWWlhhZUNW?=
 =?utf-8?B?a2l4K093ZWVBYjBDQm1OQTNOaThuaTYxK09xYkZSb0JDWHBCczR6UEV3YlVE?=
 =?utf-8?B?QmJhRWNDVlo2T1FXMkhxVGFjYjlGV2RFVDBOaE1NaEVPMGM2cE5qdUtRPT0=?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7224.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(1800799015)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?ZFdGRStvMW0wV1RkaVBvOUVEL2pJL1RPMGYwdmlYUVlyOXRHNlhVWVR2eDlI?=
 =?utf-8?B?QnZzTFdScXAva0QvdGEzOGxTdEczc1owWkM0TGp6aHlVMHpBS1VFNjBrRXNB?=
 =?utf-8?B?SkMvYlQ2d0ZLbDVtaWtCZmpzRzNQU3pYZlk5Mk5nbmx2QXFTLzdXMWtUVmZR?=
 =?utf-8?B?Y1Q4ZWRaQ2pIL0lUSU05YmVHcDJVeEt4NEpVYmxyVlQvd2hRSkpIbjRDN254?=
 =?utf-8?B?M2V2bTNsU2JDZDUvejJPQTQ4N2VoZzhPM0RYVk5NU25vMnY2THE2RXcwNEp0?=
 =?utf-8?B?RjhaM0pnTDhIdVAzTUVsOTNkLzF5U1hnemU0Ym1YSldMMnl5MXhENkxCZlF1?=
 =?utf-8?B?Tk1nR2JES3VxaStQRnlsa3FzeEtyTWxTR2hWbnE0WFZzRHNaS1ViSmJhV25U?=
 =?utf-8?B?Q3hPT21xNzZFYi9tYitvMkJ4OFhQUUcyeGNSR1hTMUJjYTYyeDN5VE5xaTl6?=
 =?utf-8?B?TWRBQjMvYWV3cVhFaENHa2VEQ0RDT0JTUkp1TTBqTHV0Y0E1Zk8vditYRjNL?=
 =?utf-8?B?K3pWZHVORFBUT0VJT3k0NDh4QzhpSEdCQTR3bGt6eFVrUGpQcGFwY1d4aDJi?=
 =?utf-8?B?ME5Ecm1JbjdnZWNlYnFia2dPM3pkcFFBTkttakhwTFFlREdWQmtQc3k2Zm1N?=
 =?utf-8?B?dzBvemsrYUJOeHgwK0VIck9rREpDbE9JOU9nbmlZNGVueFYrbWZ5Y25ITGRW?=
 =?utf-8?B?UVEzUzh1WWdIV25tNjhmSmU5TG96em5WZGpGeDZrWlBKZzVZRHo2ZFRVcHpN?=
 =?utf-8?B?c2FmN0NlMWVpWWRhVWM2blI1aUVwdlZYcnNpa2F1UXdvajBXdlhyMzgvTDNz?=
 =?utf-8?B?YWhYM3Njamd4NXZNMzQ0VkNIdVgrdnhCalRkWVJHbW8zcUxMMVgrdi9UR1dQ?=
 =?utf-8?B?QkhLdU9WV2hFc05aWks1cVJLRGxVRlAydTJKeHgyRU5tcGttRnhocFR4OElJ?=
 =?utf-8?B?c2RiQzg2SExRdmlTL1A1cU50NWVhTTFsMnVpVHFUajQ0K2ttelZONGVOWitt?=
 =?utf-8?B?L0hCa0JEdDIwbVNtUFhWL01IbTA1a0hvYnpRckxQbFdZTlhLY2dpdDhaUGI0?=
 =?utf-8?B?WDBiOXlsV1p6TUJHUVUvRUw5K3pCQWxDeHI4SThHRDdyaE5obVFtNG91aWJu?=
 =?utf-8?B?U1d5Nnhicy93N1pPeUR1TzcvYWpITEQ0RlFtZlJVbm16UkkrblVIVHBxbTh2?=
 =?utf-8?B?OFJzU0hoNyt3Z0xpQ0IzMjc4bEJtdCtZKytIMTFCdGRJUWsxTmM1amFMZ2ZX?=
 =?utf-8?B?SEgyWHZ6UmZSMUxEVi9XVjZ5QlA1MGR2K080K2hBSExjbVkzWURhcmF1UE4y?=
 =?utf-8?B?MkRjSnRscVZCL2tETjNXUHIrK3pDaHVlSWI3OC8yd21qeEVabTZscUxvdmRJ?=
 =?utf-8?B?U1MxMjU3K0FveXJTcWU0cGlxdnY5dWdSV2xZN1RWR0Z0Rm0raDZTRU5PWnBw?=
 =?utf-8?B?dG9IYkxOV3FKSENETVVYNUp3L3dqM011ZTJuUVVUejVHOW1JcXBMUm1ETFVw?=
 =?utf-8?B?S0hyUnVsdUk2UGtnNTVjQ01ySWI4aVVFbkN6RWhNUXBUa25BQzExa05iaGZJ?=
 =?utf-8?B?VHV1Mi9YNnVYc0lxNnVMbnFmUmhtMmc3UVNWRVh6M0IrWkZoUnpEMVpVS0xF?=
 =?utf-8?B?NndzNUZHcFo2QVdXSFN3ZDdzTCtid09VR1ZUOUM4cEQ2ZXVBMTU2eDUvVjR4?=
 =?utf-8?B?dHlOVFNjVWlkdUUrZnJ4YlhVVi81eEdvaVZ3ZmJVNGp4QWxkK3dDc1ROcEND?=
 =?utf-8?B?c0RTakNPMUFGN3lVbEFJdUZBQktxWHc3ZjJmcHNKbm9IYXdzbmExOGtvT0JU?=
 =?utf-8?B?NkNqbnhrTkk1ZHVsbG5RL3ljT1BDaUNvS0tBcGE5YUE4VTdDKzBmYVNETHFN?=
 =?utf-8?B?ckpBRzRKUzNJQ3NNa0RMUW5lUFBZc2IyREhXOFI5VlZwdFJmb2FVdW9FcVFk?=
 =?utf-8?B?NTIwaUM2cFlvcjczV1ZZV1huUDByQk01VEhrZFR3Q29kTU4zaTV3QmdIcS9a?=
 =?utf-8?B?R2VFdURhR3ZJQXRETWxQSUgxeFZjNDltc2pvK214QUpLVGQ0OWtPcGpsekpZ?=
 =?utf-8?B?YzFMbTk4TmF0QjE1blg0QnZhbVorNXo5SUV1blNXYlZ4Wlo3cVcyQnl2b3pp?=
 =?utf-8?B?amJKMStwdFZzNXlYcWVldDVpSlduK2RVb2pvUy9vY0ZwSnF4MExXNHFweFFX?=
 =?utf-8?B?S1E9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	xp4XPP22DNcuXobaEzUvPhje9cjGUiSLoHtVYQQejdX3fc8y9dMsyJafU/sSudva50OVhIuerPu1lIbITffdvWJRMG6Wl3Nv3hOar5DusL22wEX1z8j6R1Jp3zmemudBfB+G1pC3jNElPurBr05aPI11Xea+y+p24pNLwNDoGCIt7ugbP1vJG2l/IRPJQ9IqwA5WGZIImuoYU3Uo4SiFUWxEGjNL0UQw8GhAuCtI5akMp/g7XplNm3KB3qVvoz3A0HGkKMsXNf3KAWzR+pgQAkF7dAkhKu9jOQ22oIKpepFXmiizn/bDmTPixetTU2edkMTGNgclO6A5S1OA2iSAk1O4xhl+/zUivF/j7n+jLQkNSJjoWIJ3hEy4LMmkGElOkf9/Ayj6akqyHiN9X+yiQVvWnh7YyGo4g0thq9FCbJHU2zNZfapnFwS/fK/QDr9i2W7bq74rTlIOPoTFhHLzG6Hyc5cuGCrOKApBolsIquqZXIFkKPyA2PwesG2TCnju4HAcVzv7U1h6QAK0HqQ7XNtYamZqomdWojbYhxrmQ3iWJMO8mPnZrENi6D7DM6F7Jng9KAkSoRfxP88d7PAu+mT26cVVbYyj1dl3tnhUo0g=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 815c0c52-8540-40b6-e7cb-08dc84d4e9e0
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7224.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2024 20:28:37.3513
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pr3Tb9ewnP4PUCtdJ8DMwt+H911Tk7HJM30zE7H1xP3qR6btAYnGMogbLeBY9t+pZLoJZR7W9BhkPO7E3xTTu+W/PDJ8H61eMzQpd27e2uk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4563
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-04_11,2024-06-04_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0 spamscore=0
 adultscore=0 suspectscore=0 malwarescore=0 mlxscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2405010000
 definitions=main-2406040165
X-Proofpoint-GUID: jP-3Y05UQy1hW_bUcwVIy_fx51LCyKiw
X-Proofpoint-ORIG-GUID: jP-3Y05UQy1hW_bUcwVIy_fx51LCyKiw

On 6/4/24 11:18 AM, Jarkko Sakkinen wrote:
> On Fri May 31, 2024 at 4:03 AM EEST, Ross Philipson wrote:
>> From: Arvind Sankar <nivedita@alum.mit.edu>
>>
>> There are use cases for storing the offset of a symbol in kernel_info.
>> For example, the trenchboot series [0] needs to store the offset of the
>> Measured Launch Environment header in kernel_info.
> 
> So either there are other use cases that you should enumerate, or just
> be straight and state that this is done for Trenchboot.

The kernel_info concept came about because of the work we were doing on 
TrenchBoot but it was not done for TrenchBoot. It was a collaborative 
effort between the TrenchBoot team and H. Peter Anvin at Intel. He 
actually envisioned it being useful elsewhere. If you find the original 
commits for it (that went in stand-alone) from Daniel Kiper, there is a 
fair amount of detail what kernel_info is supposed to be and should be 
used for.

> 
> I believe latter is the case, and there is no reason to project further.
> If it does not interfere kernel otherwise, it should be fine just by
> that.
> 
> Also I believe that it is written as Trenchboot, without "series" ;-)
> Think when writing commit message that it will some day be part of the
> commit log, not a series flying in the air.
> 
> Sorry for the nitpicks but better to be punctual and that way also
> transparent as possible, right?

No problem. We submit the patch sets to get feedback :)

Thanks for the feedback.

> 
>>
>> Since commit (note: commit ID from tip/master)
>>
>> commit 527afc212231 ("x86/boot: Check that there are no run-time relocations")
>>
>> run-time relocations are not allowed in the compressed kernel, so simply
>> using the symbol in kernel_info, as
>>
>> 	.long	symbol
>>
>> will cause a linker error because this is not position-independent.
>>
>> With kernel_info being a separate object file and in a different section
>> from startup_32, there is no way to calculate the offset of a symbol
>> from the start of the image in a position-independent way.
>>
>> To enable such use cases, put kernel_info into its own section which is
> 
> "To allow Trenchboot to access the fields of kernel_info..."
> 
> Much more understandable.
> 
>> placed at a predetermined offset (KERNEL_INFO_OFFSET) via the linker
>> script. This will allow calculating the symbol offset in a
>> position-independent way, by adding the offset from the start of
>> kernel_info to KERNEL_INFO_OFFSET.
>>
>> Ensure that kernel_info is aligned, and use the SYM_DATA.* macros
>> instead of bare labels. This stores the size of the kernel_info
>> structure in the ELF symbol table.
> 
> Aligned to which boundary and short explanation why to that boundary,
> i.e. state the obvious if you bring it up anyway here.
> 
> Just seems to be progressing pretty well so taking my eye glass and
> looking into nitty gritty details...

So a lot of this is up in the air if you read the responses between us 
and Ard Biesheuvel. It would be nice to get rid of the part where 
kernel_info is forced to a fixed offset in the setup kernel.

Thanks
Ross

> 
> BR, Jarkko


