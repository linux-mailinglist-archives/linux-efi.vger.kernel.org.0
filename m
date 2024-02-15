Return-Path: <linux-efi+bounces-570-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02A9E857074
	for <lists+linux-efi@lfdr.de>; Thu, 15 Feb 2024 23:20:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1753B1C209C2
	for <lists+linux-efi@lfdr.de>; Thu, 15 Feb 2024 22:20:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DE6B141995;
	Thu, 15 Feb 2024 22:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="E0OekcgU";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="uaDcOnmZ"
X-Original-To: linux-efi@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1F0713B284;
	Thu, 15 Feb 2024 22:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708035653; cv=fail; b=OcJbVeXOcvcYh/fGvxjbvIHfc6UPqlLSYrKcFfomLo0OHARBfBDihufXoFL3cFjRuigWqfzeYRd2VG3fNiFvyfiOEptfRP0Qg0bAZlSOyrFnP3enEMmXREvc60VgqvZf+dr6FaJakOiAHVJIkMxQWy/amIDOcLZS3IdJ84rKEEk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708035653; c=relaxed/simple;
	bh=krMsH+grAC1v599Gp7Pw6YjNDek2Rxf+OAjyE7DyG5k=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=fp+wU86S8CFw/aXqczGUdSWCYy6/LYn6IxfI87fl4km4rLlxAyeff3vM04FUXnmtdfPe1z3wsGYPUnKmR/6Lq3SnkUsHSZM8lwk2IIchtlgfekhYF3hEHxY4GmW4ZFvCMqWMQV08DVX7cRXSFw9Ulk6VqzQRDoVIy8+MSHQ0LGE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=E0OekcgU; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=uaDcOnmZ; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41FLSKLk029341;
	Thu, 15 Feb 2024 22:20:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=lpo4P01gP8B8BRVQuwQXi8GY+McE0ctw6iExPb4V2uI=;
 b=E0OekcgUcmGr+tx8mdVs/S/WPeyLdBTkzdsOkc9Z3Tlbfb7YdiWEYijtf2azG1yQi0I4
 3Q82BdeIY72H/2OU78/TFn0JgE5RPwx7vpr7PukD6kviddJOf1JYPpoYdpr12hUtXV/4
 d1qfBDbo0BrJEa2vAJPXaAXr4U2HX5fjhxAUJQdaCJJrEMBspuvQEZLa/Knano/o2h6V
 kI+qi310pOfSuwFI6q5AF8/l+srbi3Ucy6pymOZTRpzmr5tpS4CF2Q4AEls640t+bEyC
 yt381SXwBEEFJAI6ao2HbJG1uklGfSQuhulVw+t+3op3and1guqLtV1dWkshR0HUFl/E pA== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3w92db3f7u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 15 Feb 2024 22:20:14 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 41FLtOUR024567;
	Thu, 15 Feb 2024 22:20:14 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3w5ykhh29f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 15 Feb 2024 22:20:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DfKMLMEBSkNqV0efH4d8mqx72UnNqVLpk7yXbG9mUyNnHVdb4WI7jXwEGtKOHKx6in8W6jt3ScF9jTrwLYu9lwoJGUd10YkN3X2792duaH/WNJwdG39wU162Qjznz2CN8yXlL68iZ8hKZURnbHzR4pHfi4ETDpdEyWxvIQhiZVInVNYM+NNWOYWkTXA9YpUcL/PP8RDBqbI83WVo0sGz7bTTj9TQvd4Q4mE/HbC0NsFviMUexPDUh2EAF/x3Ayr3AxT7iwxltYtgyvYC690I1mcUbNPg9FU7dVCACXii+Rb7iYQsLx7PVOUhqkWNInm2tend6ajRm6hxLKo+HyL3cA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lpo4P01gP8B8BRVQuwQXi8GY+McE0ctw6iExPb4V2uI=;
 b=hCt8MsczJZcBjVpiRYJtZ0AG7cno4hIhTqt+xgzRRIn4xGolPoGSkI8UOepRNMQlCn8gJn6irZ09ov8w7NL8Oe2Bs461s59RACuPKbXn0z7uitSnmEE327cClqDdb1XiplIANthGRmsMlqgJPkL2caNgquA9C9y/Z4BY7+MuMo1nGriVyhekedZmMLPOYQs4WU+ETe8jT8EhyD4v8MgWvuIBpQMaiPLz8NGUv82a6X2XnwcFNXKIQgMh/VvgsVBfA+TZDXKh2/FIU0CbN/YQGdv2sXy/XjJck/AIRQE0owxWUDNK8qpsWsbmpmOGuNUrUT0K9Tut8Fp5dbnYYD8LVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lpo4P01gP8B8BRVQuwQXi8GY+McE0ctw6iExPb4V2uI=;
 b=uaDcOnmZ5OM1CnypyxxbqcgRTDx9I/En4es29f2qsyzdBHsAEbX11vhAtMBi8Xd14WXoxZq3uvS8c2rsIu+eDUcQbchPxzIgwWSffKqLnPY6rLzf4OuW82zCuR9opzz6qba2R3PjXws4pTvJI+4BwYhNRpjJS3RidcbVdxgg7QI=
Received: from DS0PR10MB7224.namprd10.prod.outlook.com (2603:10b6:8:f5::14) by
 IA1PR10MB6243.namprd10.prod.outlook.com (2603:10b6:208:3a1::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.41; Thu, 15 Feb
 2024 22:20:11 +0000
Received: from DS0PR10MB7224.namprd10.prod.outlook.com
 ([fe80::5063:ca40:3a17:7992]) by DS0PR10MB7224.namprd10.prod.outlook.com
 ([fe80::5063:ca40:3a17:7992%3]) with mapi id 15.20.7292.029; Thu, 15 Feb 2024
 22:20:11 +0000
Message-ID: <01c5bcf2-33fb-4723-bc6d-590b5d2d2eb9@oracle.com>
Date: Thu, 15 Feb 2024 14:20:07 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 03/15] x86: Secure Launch Kconfig
Content-Language: en-US
To: Ard Biesheuvel <ardb@kernel.org>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-integrity@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-crypto@vger.kernel.org, kexec@lists.infradead.org,
        linux-efi@vger.kernel.org, dpsmith@apertussolutions.com,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        dave.hansen@linux.intel.com, mjg59@srcf.ucam.org,
        James.Bottomley@hansenpartnership.com, peterhuewe@gmx.de,
        jarkko@kernel.org, jgg@ziepe.ca, luto@amacapital.net,
        nivedita@alum.mit.edu, herbert@gondor.apana.org.au,
        davem@davemloft.net, kanth.ghatraju@oracle.com,
        trenchboot-devel@googlegroups.com
References: <20240214221847.2066632-1-ross.philipson@oracle.com>
 <20240214221847.2066632-4-ross.philipson@oracle.com>
 <CAMj1kXHxvmHo-FWa8PXoZSTVyeSsgFyOaSuXP=2Bhj2YjxCALQ@mail.gmail.com>
From: ross.philipson@oracle.com
In-Reply-To: <CAMj1kXHxvmHo-FWa8PXoZSTVyeSsgFyOaSuXP=2Bhj2YjxCALQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR01CA0068.prod.exchangelabs.com (2603:10b6:a03:94::45)
 To DS0PR10MB7224.namprd10.prod.outlook.com (2603:10b6:8:f5::14)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7224:EE_|IA1PR10MB6243:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a58b219-cc2c-42f4-ff51-08dc2e74464d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	2KAuIDN84u11zKRHgYhBLfLrkytFnl+zFnCiu3jGlNOq4dhfhHy37oZsj0p7jMyZliK8W7vIGhdLopXUQVIgZIo/WMznPmaffs7VcI6RdRl+fZ3JzUwIYItz8tEVTFi4iMWX8E78MGeaLacGYHwLqN+onQAhzHr/lKlbVETMwCGBwZUJlUl6cf6HbPaifvmBk5gLXIIQaGzTk3kPUWRHN5lAOLC/g8w1+tWzz/xAV1fIZwea3s7g+6cWPCmZ3ya9zc1toAmACIRH7L5vZBkMPxw4Jc+q8lDxsvukhPsp0zzv3I+bsH3fXWr8DEV1UR3veEgy8oLGeaL8sZvuiQ8zlLDVZXG9rKgo/UYfbFTDZiAiP8wMVIGsAogYSpJ88V4xXEG6ArW1IrRvB3FxgMG5akB1myk5zF3U+a5dqgZrC1j5rTmTE2Wg+AXI8m40dqZU+9+ZEbCBzPbJfpdNt6z+OdNU3IMc0Oxts2t49rLNrNb2DET4pWZVOHj413+h8tw68TH+HR5s2AiASwV3tstmAUf5TBKmKw2nZx+/vu/G49ToFh6nkdeiKQkurBxCSM1h
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7224.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(346002)(136003)(376002)(39860400002)(230922051799003)(64100799003)(451199024)(1800799012)(186009)(7416002)(31686004)(2906002)(478600001)(26005)(8936002)(66946007)(41300700001)(53546011)(2616005)(9686003)(66476007)(6916009)(4326008)(8676002)(5660300002)(36756003)(66556008)(6486002)(83380400001)(6512007)(316002)(6666004)(38100700002)(31696002)(86362001)(6506007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?L0ZvNjNoVGptSVhlUnZUN2dCdytZdWtMbVNjZVArRWNSbzhXbFprV2hxZDJS?=
 =?utf-8?B?bDZEdUliYWdUY2ZZakd1aytoaHlTSlBlaGdYVVZHUlR5dnM3VUpya3IvL3hI?=
 =?utf-8?B?WXl1VlEzeFhrRlNyZkZBVTJGYkV0MVNSVzFCYk96c1VMSWhrRjVaZW1rcWdo?=
 =?utf-8?B?ZVdQbkZKYXFvS28zK2lSaTJERGlUNWhLM3dEcWtNVnZwRERybnlUMWJ0blhl?=
 =?utf-8?B?NzRNZnhGUkE0TnJ6TUwvUjdHb2NSYjdSeDVkM0dpV2tvRGs1UEpuYkdsWnlX?=
 =?utf-8?B?dWFmRjRMWjVMckxIalg0dlFZS3RYeG0vcUMwZ2wyLytoeGhvUUZiS1JVTW9K?=
 =?utf-8?B?ZGZsWld6Z1I0VnM2SnlvVVcrV21rS21ubEdMUWMrV0xMN3FXK2tZTWVoS3lV?=
 =?utf-8?B?TXhRaUh3YnNvN1JzeXFoV1A1UHdoTFc4eUtnNkVSS09ROUVZS1FTeWx5WGdT?=
 =?utf-8?B?Z21aRmZzaVc1L3RVS2tkRXhHeHU5QnVTNDhCU3pXYlA3RU80ZHZSMnpUbFRh?=
 =?utf-8?B?eEJiTGs0eWtJU1ZFOTVBR2t6bzdVczBxZEZtY0NmYTBHYmphcUhDL1ZJb3ls?=
 =?utf-8?B?YjhhYXk5Y3VkeVo5MGlseDBCeGRqRXZHRncwUjZ0NXA4b1BBN3E0KzlJYmtl?=
 =?utf-8?B?NDVQY25nWFYrbjZjd0FmSCtEa1BzNGFrWlcveFpGQTBMM25JT2xFS3F4bVFE?=
 =?utf-8?B?d1pEZFhlakV5UGtIRTRteVBwWFhkbkZuYkVJZjdJYzJZV3ZSeEpINTdFTHJp?=
 =?utf-8?B?QzhMcVkxZ085SUhYbWdCQlBKNGtOc2ZOVVlFa0tIR0l6WFE0amgrNnFOZmd3?=
 =?utf-8?B?bHBJdWVEQUc5bmZrU0ZydVg5Q0FMaWRiT1BPazNiemRUOVQ2WWwzeERRZlpW?=
 =?utf-8?B?dkZqK3Q1cUpIUXhrMHpTYVR5SnBDbHhNOXk4ckN1SGZCcXRKTXJuSXN1WUht?=
 =?utf-8?B?cWZGcktCdk94ckx1cUo3YVFmUEc1NUF2czFibWJBQjd2TVVEWWFYS3lTVVhx?=
 =?utf-8?B?MDZQUms2NW4vRk1ERXU4K0plQlh2a2N0c0c1c1F1eTVNYU0vMmFHWXpKWUh1?=
 =?utf-8?B?N0VoekphZkZZSzhZSDdVTGxhV1RkK3h5eXNua1NCNjE3eWxZN2VNMmM5ditr?=
 =?utf-8?B?S0NBdnFjeFNmVllrYlVmZTBSdUtMekNLZmhsWVd5NmtYeDhFQlZJNEtpQXlL?=
 =?utf-8?B?T2ZxU3NvUllNdktodjBBRUc2dWFIRW90RWZPWDBrSWhGM3VlS3d5QzA3NWtk?=
 =?utf-8?B?Q3pIYzBnbmp6Yk4xMGtKOUZVelJteTVXUVRyUVpHRG1ldVlxYVhyQ2pvUXln?=
 =?utf-8?B?WkdDY0M1RGdMR3VuRnVPL0NMckF4Q25QZjlkR0NSTWFockczeGFZOWlWN2Nq?=
 =?utf-8?B?eFRTdGZRbXJqWVc2NmR1elg4Wjd2a0toR1BZb21jYkYyNy82T3RQWXVVcFA0?=
 =?utf-8?B?cU9tckdMaXlkbWFTYnozRlJCTnY3eWlnWVhZSTZUUGVCSVo5OTBwS2VFZTFB?=
 =?utf-8?B?NDE5UXNMUlhJenhKeTVPMTJISTBzS2grR2ZWNDR1ZWtBTWdsaVNSRGMxTzJt?=
 =?utf-8?B?dURpQS83ZkUzcGJyeTZFa3A2TGhLSndNNjRxeVg3N3F0NTB5WXdMajVJeWpC?=
 =?utf-8?B?MjU1K014LzVFa3RWdkFMUG9KT2w4c2UwVVFXYnk0MGdpMDNUMTdMTzkydGZh?=
 =?utf-8?B?cGoxODZSK253Nm5ZK0l6REk5Qk0zYUtFWmJpWGpvY3F5di9MN0U5N2NDbzhX?=
 =?utf-8?B?VlUrUnpLRDZybVpOVWtpWk9XZElnYzY3cm0vZExTeDNsS1NrMmVNWkhONm03?=
 =?utf-8?B?SDZWcFlJbnhnTkFVMWJJMG5WQXFxNndYcGJJS1c4NlBPWnptSG9aeHZuKzJi?=
 =?utf-8?B?cE81d3FDVUJqVjJLaVNUamthRDZVMTlaTERZaWhaK0xQaFYwREVrOERBa1J0?=
 =?utf-8?B?MFc5Q1hmeFdSNXhsd2ZtVi9tNWJSS3FyVUFHcmdVN3ZnMWhPb05MLzJyMW9u?=
 =?utf-8?B?MWR5L3ZYVThiSFROTGNMTjM3MmtqK1VXeEIwYnp1eTI1dldSTjVLcmNlckx5?=
 =?utf-8?B?dUFMR2Rwb2NDYUppYkNYWkZ3alVJZ2VYUFJVVUxpTXlGMVBma01BRFNPczZF?=
 =?utf-8?B?Qktqd0VhK3hLbzgxODlMdFBiVmxocjlGZWtCdi95L1IrcVo2eWNUTWJiK0Qv?=
 =?utf-8?B?Q2c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	SpYHvfdLJeUxWj/P0oPB/kaHlNp7TeRBAfXrVQeQuBJIu1FoX4pYptEyDWVXbm02mR2LkBevYEK4J5zcrVPqmxdNXaiKu9DWlS2DKPQ7E1TLfz2N+wTFhbEPQB6h06Pmry90qaVD+Xd2ixmFgL0XZHuAQ9BOKBA6PohLluZyeOXZh2XyHa3cG8fK2vyIqYBrVyprzl0haPUCbpICnIbI0FTMvM9KkBSUEU7Or/KFeogbx9JaBu1vphrl7Z+Ail3CMmJGHCyQF55K790lLO7howuOKeZ9eogbTzpnV/uqPLemXmjQ3aQ3gTHOkxzxGaSFoEnmAnpElgs1RZsBLkhDc0S6bf9UpMinszij9z5CSvldv5SjD3LdJz+Y9u/SYAbetNOvHJzNIJQ3V27fkupk4bHEZKrZC5l2tozdTBmY7s3Vd1Kw05AzQuN6JvGK/YCPFQ+lsaZTCvVyDWyNZSbWH/uip3QgKflTO3aoUyMTWvaHBtrapYPRcV5WjBJVWcSadSeOswMoZRipQeTK3v+rxxRaml8TPZubx+ir+VKbYM+QpRgK72UZavFqgkZNjGD0YH+X+cjsQ2LTFs8ZEU+xS/34ZwwaJ54MwAaWgA6kMQs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a58b219-cc2c-42f4-ff51-08dc2e74464d
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7224.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2024 22:20:11.2593
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7m4mBBKYKiXUt5t9mQFqD9TcCgWkN/mm7ansQ5N33KeeLclr0CfxMPV7RaP512QbCYWJa+N8jpVsSX8lh/qo91u7GcbU4lMP3LiUxNFH9Jc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6243
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-15_21,2024-02-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0
 mlxlogscore=999 malwarescore=0 mlxscore=0 spamscore=0 suspectscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402150174
X-Proofpoint-GUID: dC6RM-GrzpJ4PBOIgKQnDHSGxDAKxXZF
X-Proofpoint-ORIG-GUID: dC6RM-GrzpJ4PBOIgKQnDHSGxDAKxXZF

On 2/14/24 11:59 PM, Ard Biesheuvel wrote:
> On Wed, 14 Feb 2024 at 23:31, Ross Philipson <ross.philipson@oracle.com> wrote:
>>
>> Initial bits to bring in Secure Launch functionality. Add Kconfig
>> options for compiling in/out the Secure Launch code.
>>
>> Signed-off-by: Ross Philipson <ross.philipson@oracle.com>
>> ---
>>   arch/x86/Kconfig | 12 ++++++++++++
>>   1 file changed, 12 insertions(+)
>>
>> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
>> index 5edec175b9bf..d96d75f6f1a9 100644
>> --- a/arch/x86/Kconfig
>> +++ b/arch/x86/Kconfig
>> @@ -2071,6 +2071,18 @@ config EFI_RUNTIME_MAP
>>
>>            See also Documentation/ABI/testing/sysfs-firmware-efi-runtime-map.
>>
>> +config SECURE_LAUNCH
>> +       bool "Secure Launch support"
>> +       default n
> 
> 'n' is already the default, so you can drop this line.

Ack

> 
>> +       depends on X86_64 && X86_X2APIC
> 
> This depends on CONFIG_TCG_TPM as well (I got build failures without it)

Yes I will add that. I may have to add a couple of other things too.

Thanks
Ross

> 
>> +       help
>> +          The Secure Launch feature allows a kernel to be loaded
>> +          directly through an Intel TXT measured launch. Intel TXT
>> +          establishes a Dynamic Root of Trust for Measurement (DRTM)
>> +          where the CPU measures the kernel image. This feature then
>> +          continues the measurement chain over kernel configuration
>> +          information and init images.
>> +
>>   source "kernel/Kconfig.hz"
>>
>>   config ARCH_SUPPORTS_KEXEC
>> --
>> 2.39.3
>>
> 


