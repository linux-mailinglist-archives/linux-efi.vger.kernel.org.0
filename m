Return-Path: <linux-efi+bounces-1255-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FA1E910DC3
	for <lists+linux-efi@lfdr.de>; Thu, 20 Jun 2024 18:57:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F3F811F224A0
	for <lists+linux-efi@lfdr.de>; Thu, 20 Jun 2024 16:57:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D0FD1B3720;
	Thu, 20 Jun 2024 16:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Q2vvg1B9";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="oEKS/6+2"
X-Original-To: linux-efi@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BB151B14FA;
	Thu, 20 Jun 2024 16:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718902620; cv=fail; b=mn9rwAmZGwCI7yp9cEHeF0hIKTE1e4drcwU0wKCa8xAxg+A3ZRXCrckGYIH8G2Ux/Oy+lILhZAuKIneX3u1yiUbJ5JMArr631q46YVLpuEMcWSkIhtsw5V1moR9rk/gipuqHfSN3MG2UaNhtKf13T4PyuP+YtPCoCs7BELN6bBI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718902620; c=relaxed/simple;
	bh=uL/H+BRnYhlE6sQaDP6z5s9Q1kvYkRnpI16sRhnOD4g=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=LGl+r9KExuxmRCWm1Q2l0H3xwBPpKyBK5GGtNggENXQg2QGv0elUywjQHZU1DWEaPGa0fsbiWOxUis963Wr8g7I/Y8kPA/sfWIMDSWWlNhPanAF9vSxLVxhvJaO53LZxERm6BNLCXViY6YzSX1UUUJZXuB7ryge7APCDI+iKzBo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Q2vvg1B9; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=oEKS/6+2; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45KEPDkY004153;
	Thu, 20 Jun 2024 16:55:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	message-id:date:subject:to:cc:references:from:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	corp-2023-11-20; bh=s95lhOFBSekBVWt/O2G5LYCLHy1TkBI+iCznRGW2XRE=; b=
	Q2vvg1B9Waahrui2Xb/4hvYrdSfX07S28Pw8UCKjUO+AIDE7ZoG7XWaqDGRfAAmZ
	gADHDbVxErVsF18nk1Rfu8qFH5eIcsxv0HyiSkuTzC/+gK6MA2ujM2yHs+XaEbFv
	zJ5Pvch+0AUkZpmzeR+jV932QN9KhDa8CTYsglN588W+o498N1RIA+d6kMJTvcTZ
	1d8zEJLej0GMj5SIgysjvf39zM1qXXHivUGOnLQH+08UDxbhzRewzKUwx4F/KelO
	nMGasnNTN9Aj5OFXnMqQIFkj65GgMDjgr7Q4c8jz0K3NVDiiai1snB8LdkADO2Pd
	XbRNBxnwB6+q4+25URg/BQ==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3yuj9nbpk9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 20 Jun 2024 16:55:43 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 45KGJ4qW035484;
	Thu, 20 Jun 2024 16:55:42 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3ys1db0qnj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 20 Jun 2024 16:55:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eHFuo9PDgXhhwYQyd+bNwJnPS90fNawJ6rbCrDHGZlY7mLkUaYhRH/CkwSpdlpKTQfx5iuACzzkcltRu42o2k7U/keq96VFWnKmaMrXcaRg8EyHbzWci88qt9MKCiT2a+OWFQxd9NzDNfJVqalKeIFPoT9TUDvP7fQBS5jp/zupRpXvpazdbP2Jv06wYXCSmvK+97f9CFoxnD2Uya5lNZ+iiXgC7iCw+YCHxEDsnLUfXXDsODvVCYTGP3eY6VMz3Uw8qMLMMqAmfxCtBtFbxMqQ+ylZyCUCUmLRJxJuLQ/7pkUJRBbCnupfaxjjePzv968BMCTbd7ftlm8BF9QNSmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s95lhOFBSekBVWt/O2G5LYCLHy1TkBI+iCznRGW2XRE=;
 b=RkqSaSyEECbDV7aBNgZGNaWfQ6gXmGcMet/vGAQtqhPdL6cBbGPs5wqwYzD7BPclvpPyvff7ns/xI61v4SzfP0K2o5qfLwtgZsGK8XItilB/cc0zsuR+OmRS5hsIAhF6/rZnHBos9jyVHiHrgbpTGP2axQkUVR8khkyoVUnk1gB93H1clt8tJAHvI8FVq+UsZUhII7mhW6iEOvbxfeowD56m8iGKv4EqApxnJmGgOCtmzvP3Lejy/nG6wRXCr9Esegz3QrBRQtQs5gpgFllF5Pi2OyDS9OWSOOPf+C5P7irli24AmqTBKk41YO7vAIgr8e42M+yktepo3AhSj/F9AA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s95lhOFBSekBVWt/O2G5LYCLHy1TkBI+iCznRGW2XRE=;
 b=oEKS/6+2z4dR03IuqcESNakKbYz3xwyuQk+TlZa8SM8neGdSgd0JbkDU1/zQHO02NqrGjzSDvHIxWLiVph/eaYRy/M5RVQ4EW5FMVI6b7kmVQlSm8chv0qv34amnAuSABCIbLk7PnXgc6Fky+3V8p9n5CReb3bSwrZYKuRY15jk=
Received: from DS0PR10MB7224.namprd10.prod.outlook.com (2603:10b6:8:f5::14) by
 SA2PR10MB4746.namprd10.prod.outlook.com (2603:10b6:806:11c::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7698.19; Thu, 20 Jun 2024 16:55:39 +0000
Received: from DS0PR10MB7224.namprd10.prod.outlook.com
 ([fe80::c57:383f:cfb2:47f8]) by DS0PR10MB7224.namprd10.prod.outlook.com
 ([fe80::c57:383f:cfb2:47f8%3]) with mapi id 15.20.7698.017; Thu, 20 Jun 2024
 16:55:39 +0000
Message-ID: <bc28c0a0-81e0-49d9-bc3f-fdeeabb3aedb@oracle.com>
Date: Thu, 20 Jun 2024 09:55:35 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 04/19] x86: Secure Launch Resource Table header file
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
        trenchboot-devel@googlegroups.com
References: <20240531010331.134441-1-ross.philipson@oracle.com>
 <20240531010331.134441-5-ross.philipson@oracle.com>
 <D1RFWFIJEYWL.2FC7V79321264@kernel.org>
 <1eca8cb1-4b3b-402b-993b-53de7c810016@oracle.com>
 <D1RLBMTUKRFN.34KQXEFZTBA08@kernel.org>
 <249a9b27-c18d-4377-8b51-9bc610b53a8b@oracle.com>
 <D1RNKV4JIE5L.1LNG82UAC916M@kernel.org>
 <f66de08f-4905-48d6-8bcf-5b1ab847492f@oracle.com>
 <D1RSB1PB5XGS.2X032M0E1VMJW@kernel.org>
 <a865a25c-336e-47de-9718-de4cb957e6c2@oracle.com>
 <D1SPFVXS6FOG.IQQB3INFYEF2@kernel.org>
 <23961b5b-a52a-483c-876e-e5e39d9e6c01@oracle.com>
 <D24EVSK6GUPH.1P44T5NNBWORU@kernel.org>
Content-Language: en-US
From: ross.philipson@oracle.com
In-Reply-To: <D24EVSK6GUPH.1P44T5NNBWORU@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0195.namprd13.prod.outlook.com
 (2603:10b6:a03:2c3::20) To DS0PR10MB7224.namprd10.prod.outlook.com
 (2603:10b6:8:f5::14)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7224:EE_|SA2PR10MB4746:EE_
X-MS-Office365-Filtering-Correlation-Id: 0fe6bfa1-795e-4748-4d9b-08dc9149d043
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|7416011|366013|376011|1800799021;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?U3R5WXk2MExlT3FheGJZcERPU2xsaDFIZ0QvdnI0K3p6QUZPejVwMWNWNk85?=
 =?utf-8?B?MDRtU05icjYrRVpnYWZ1bU5MTWNqUENwbit3UU1lMk1NU1N0aDBYQ01Wck5U?=
 =?utf-8?B?dkM5SUkzK1hJa0dWNjNacExVMm1SMFAvYklMVXc2TG91K3ltamFYYitNU29n?=
 =?utf-8?B?VjZPUWErOGlMVGV2ZGJtRWJENmJhcHliRml1N0lUZG84ampheVBtclgwY1Nl?=
 =?utf-8?B?MEZVWWxlVzVpNkVwRTJuODB1RzZYdWtaNHF4UXlNaGFLYWRhK2dwR2J4MVk4?=
 =?utf-8?B?WWlubXNWclVnOEFnYlFpUFRRSU9McFV0NXZjY3RTNEVpVnBPQzNTSjRlWS9u?=
 =?utf-8?B?clg4b0Z6bUw1aUNEajR3c0R0S05BRnIvbGJJcEJNQVBqRlRxZGFVblNNWWhI?=
 =?utf-8?B?cDhGZW8rTGVQM1pUa2pSL1Axd0pyazk4d2ZVcktUTTdTbWRoYzJDUEdFd2lL?=
 =?utf-8?B?TmFCN0FHSEhma1lkUExodHRjd0dyNWtZaEQ0dkplcUZoZ1I1MzN5WFlvSzdR?=
 =?utf-8?B?QnQ4VzVBQWpuRUw1ODdleXljZlR4VllBN0FOdEladnY4NG13ZUFnbU4zcW5j?=
 =?utf-8?B?dU1vaEtvWEZkOUpFWWRWcHhjeDZkUC9PQVNNeVhTOGw3VUVpZG9YemtFWVJr?=
 =?utf-8?B?TmsvQ3ZNZFl3cXpsVWxYV0MvV2xkSU1QalErZ09yL0Z4OXhCZHFPbUltNGhD?=
 =?utf-8?B?TEdLUUg2NmxyQ1pvcDJ4c2s3ZmhOeXN6SGNCaDRVbUJkYUhUTlVCZjdER2lG?=
 =?utf-8?B?RVJUUDBEak1ZNDVrWS9VSE9ZRFk2eVhaZE5SS1JIOGt5NlpXdVFHVTBudlI3?=
 =?utf-8?B?YWp3WEdobHZ5T0xLWk8veERFd25iZU5RNUZDWWpOa2tZTkVjT1NsTElkWkJZ?=
 =?utf-8?B?L1lyZGFEK051SVc4OGg5cTYycG9GbTRTVHJSYWdXeXJrVkNOMVozaDk1ZHY1?=
 =?utf-8?B?czZWcGdSb1QwTVY1czRXWktCS1poZHQwM1I5NTRMVUZBV1VlbDZzbnBnTHk5?=
 =?utf-8?B?TTF2aU1uejBjcnJRR1VpSUgvUHZZdFZkT08xQ3JGV0Y5ZG4xY29RWGVjZE9r?=
 =?utf-8?B?SG9RcWhFdnZ0YVNCL3N5NWtJM09ncDZLcW56RldzTFptNkFIM2tPUFFiYW9P?=
 =?utf-8?B?QzhSN1c5S29oeGFhMXV2ZHpHdU8raTNGUGFoK0FWb0d6dkZDNEZoeU9VcU5r?=
 =?utf-8?B?TTFDYUd0WjJDMndzTVRNTkVRT1JVYUlyQ1pod0tIM2t0YUlZNUhPWnZTWTF6?=
 =?utf-8?B?T3RwZEJSNndWOHErNHFMaW1JelJ6TDA0TEo4MmlFYWIrODVJbTVqSzU0SXIr?=
 =?utf-8?B?LzJOT3pDdFRwK1dycWw5TWVranFTcXo0T05DMG9PQStaMFhNNlVaK0MrMGZo?=
 =?utf-8?B?R1JiRksrVUZHdE0xNHh6L2E5bllHVDZoUTR0QkwwUlR5eHkvVDhKWmQ1c1hQ?=
 =?utf-8?B?ZXoyMWFOTTZoQjRXK0JjMUx6d0RnN3NjKzFJUzBRYVRKa3FrSXlrdWNXVDBY?=
 =?utf-8?B?MVU3N3NQV2tQN0xWbk1HbHRaby81YnFKdEp4VkUxK3QyRlovRDlsQVJiVzBR?=
 =?utf-8?B?RWdJM0pmZjdReGlrZytMOXFCeFB4US9Ecm9yUWdSc291blNEQ296L1R2dC9k?=
 =?utf-8?B?U1dnR0I0WGdsclFIM1JEQnJsbUhPREo5V0c1SFQydWJWcVBxRmpnK2w2bi9Z?=
 =?utf-8?B?MktTVGhLZTdUbndBRkFVcDYxUkg5UHliaGlUKzVZVnkrK1NqSjh5cTFyenVB?=
 =?utf-8?Q?RUVu3jAqXfhMk6MkP+DFL2zb2K89aJEN4DQgPtr?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7224.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(7416011)(366013)(376011)(1800799021);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?ckVJVFlmOVl0Q3hKL2oxSmV2clQybU1hUVNCcWdUTk1QV1hSSTJ6TUkrdlVE?=
 =?utf-8?B?cGx5U3kzcng4bDRSek9ESFZUYXNtVy84WkZET1habW1OdkhrODA5ejlIWUJp?=
 =?utf-8?B?c05GUll0bXVyWjAybWVoaFAxdTVBVnFEWXNrMzM4M2IrTzdsbE5kU3lITXZq?=
 =?utf-8?B?L0tRYjZKbG1DVzhCOTBlZSt1MGNiUytYVm91MlpGVjYrbFBONi9uT0JUSXhM?=
 =?utf-8?B?eUVtWkRGaVR3Qmd5ZjJqTGxqeUNDZGxVR1h0TG8yaGNBdUg1bzJwa0ZoMTNC?=
 =?utf-8?B?N0pGT0hmNld6RnBxaUtJT3NzenFxdmNUZlJqZmkycDFGTklYdlFncjBtN2Zw?=
 =?utf-8?B?OUo1UHJaYkxJV2NKTVVqc2w2TEg3cU5RUlY4aXFaRit4Y1RLZGxOVC9Ybldx?=
 =?utf-8?B?cnV2clFQbXFHNGlTSzcvK1BSMmxiMlczZU1lZDZrMEMySXk2N3duWDFqNWtG?=
 =?utf-8?B?RS9iRGF3b0pEdEdtSThtZXFqakZrbTlGNFlJWlIwcHJhaEZFTk5uR3dzQWlj?=
 =?utf-8?B?blBiaWlZeVErelJZODFYWVcwWnhkZEpXVFZDTDNuQXozTWRNdS9ocXNKYVpr?=
 =?utf-8?B?T05GTnRoNWkvVFkzSEJFcEZJUldwQ1JJekJYeHBYa01FRDJwZmF1SkI3OVFt?=
 =?utf-8?B?eGgzb0NiNUFkdzNRZHNkaERZTFNUcHlENzJCTXpTdjQrOHRLUlRnZjRoSDZV?=
 =?utf-8?B?NEdzbmVyV3dzNkdUU2lZNE81N0lXNk0xb3BFUFFtVUlsOHF0YTg0YVpmOVp6?=
 =?utf-8?B?K0Voa3pDdys1YWQrOFUxVHVBeG0xVkZYMHp1ZnFSK3VqS3lSTEQydTl0Slp4?=
 =?utf-8?B?bEpzZ0hLc1RmQTRFK05iSUt6ZTBrSVhjYWFJbS9iaGhLeXdwNjJzWCtYTUd4?=
 =?utf-8?B?MGtrSXh4OGlXUndpSktVNzllSzNMdjRsRHZkNk5nNXB2Z2ppMkxUR2FXVXcz?=
 =?utf-8?B?L2krc3p5Z1NZakliK3Q0N3lsTHpDcUR5SXBmV0o1b0Z0YWVmZzJsZVR5SXBz?=
 =?utf-8?B?dGJ0MktyZVVIeVY5UlI4NmljMDFPc0xOUTRxUEZBNURtbytodjh5SGdZZWk0?=
 =?utf-8?B?VmJ5R25LcUFwVjNpSFFkN3JQK2tLYVNveUk0c1dBczJOSnQ3eStkVGtKRlVX?=
 =?utf-8?B?ZUd2NjB0dEpXdVorcitQUUtRM0xKYjB4SDkvTlc2aGdEQWFTMmdqK2JmSXRt?=
 =?utf-8?B?UlpCS1A2MVVkdTlXY0dmMk9tM2l3TmJySU9Yc0JaY0RvTG1ZRE5rYTJja3pR?=
 =?utf-8?B?VUdldDJxZTc4VXJwSFFqcEdHK3FtSmNDa3JseGNMNDBYWk1uelpIRmVGTG5F?=
 =?utf-8?B?ckIrVXhqRnkyaU9pRFNWdkFqTGJxUEFNS2ZTSWtMdTd5K3R2TXBtQjV5M1Q4?=
 =?utf-8?B?NmNxc2cwd3E3QjR0eGV0TUZSZTBmZmE1dzZvcUsxSmw0VFVtbkdSb1QxUjFx?=
 =?utf-8?B?blNuYnVSc1ZKN0wvL1JRdENlQkJXSSthcHI4SWF2MzZzV2JKZHUyOU9TZnJL?=
 =?utf-8?B?STduNUVDNFFYb0F6SzdLemhvWUNQZzRiZ1RxK01KUGJPWjRTQkoyOXhWdXA3?=
 =?utf-8?B?SXNNSVBlZmtqR1E4amEzaWJLbEFzT1dMOHJ2NGUxWWJUUm53OGwxMEl0eXZn?=
 =?utf-8?B?b0QvWlRnMmhPczlRU3drZmdoT0doczJQUUMwT211N3JJK2U4RjhzVWNzQW5R?=
 =?utf-8?B?U2Z0alBEaVpSL2hZQWlJQVVXVXZtWUtQMG56Mjc2R2tOUG9GOFZkdTdGZlFG?=
 =?utf-8?B?U2J0bElsQU5teUh0ODg1VDdwL0JwbXdRcXNjcTYvcTZ3RmhWcjBmRkZXUEI4?=
 =?utf-8?B?Wmd1MHlwTmZ0NjVQSm50OS9CajBZa1JlN0l0YUEydWU1bzJ6Vkd3OGZQSG4z?=
 =?utf-8?B?Szc2SlNEN1FyYVJ0NVNSZE9HbW1kSmlxRlBkcng2K09tOVFZbmUyRkthMUtS?=
 =?utf-8?B?eGw5MFJ6VmVCWnhKZXg1L3dTOEVuN01jUS8wa2NQcld6Q3dzRGdaSklFUDM5?=
 =?utf-8?B?NTNrc0Y0dnI1RStoR2YyWGQ5Q3hKNlJEc1ZxSFJ0ZmEyeWIwTGtaY2Y2NDZY?=
 =?utf-8?B?c1hNVmN1U1JOVXZLcEpBK3M5dEs1QzJBaHYveWJsREV1aXhyQmVMY043TWJF?=
 =?utf-8?B?ZmpzM2R4TFZITVNyaVcwRC92WEQ3Um9CY3ZCaEZFaytGYitDQjhYeGZyUVRH?=
 =?utf-8?B?Rmc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	3bh1fmQjlkZTLv2S+Cl51uLApAR2/0+wD7C872bMCOU0aJFkV9loMXyHRQLtqDOlJHNX1+wla58bNfuDw+k2WNMuZ16iaDNkKJnyWq/FiQJsXiKkzTGplIUmnpD+6LJi0O/wyPZOhbS2/eo84bXx9GSVgrPe/lBXKsavktr2QeDXyxtP762YWsogr0d7mOpQKPgNl10hV+CGiNbS7tHZBBduaUKJ7VJZMdTxTYEO0Om0GpfTQGqKpDXuF2n7m/e6I2NUz1I6VT4ji45o78NmeNTbVg4HHkCVNRthE+9+kTNW0Gg1r13sXoV+/AMm2Y9l7fDFnzwar5N1RS4ipNkQYfELwRbjCVllOJNH1CnBw4wJ/uUIxz3M5rnQauDl9CgSPnkiFGrNDtZ/Mq4DF6xTW9wzlpyG5BVt6bhbIA30qfw/r/2BMFL/UEvLq8fjlZNL/Od/oy86WQ+xOao/iuYenkB5NFmJobogAR88S/ZIrZb2snFLfVlQ/nd8zdOSGKgp4zwhMWVZvbQZx/eWsxLjAIpyE4PqFMZC4UIbaAjARF9U4Yjd+VzSq1Mcc3e4yVONTOBEjZIgR5fiUgqUCruZNmsUN63VRrOanQgIFy8CFVM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0fe6bfa1-795e-4748-4d9b-08dc9149d043
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7224.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2024 16:55:39.4233
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 68tmiX8PB1x0/CQgtYPmwkqUhNnVJNRDfUKCMSQryDM2LHOfYCDy1qLVUdM0fqfXMHS1LA/BpAz/aQLXPennbKBbJijf+YGhTLvmxTfTmjE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4746
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-20_08,2024-06-20_04,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 suspectscore=0
 malwarescore=0 phishscore=0 spamscore=0 mlxscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2406200122
X-Proofpoint-GUID: PgYr73esN44cbP0w3wRc9mPmesqJZwyD
X-Proofpoint-ORIG-GUID: PgYr73esN44cbP0w3wRc9mPmesqJZwyD

On 6/19/24 5:18 PM, Jarkko Sakkinen wrote:
> On Thu Jun 6, 2024 at 7:49 PM EEST,  wrote:
>>> For any architectures dig a similar fact:
>>>
>>> 1. Is not dead.
>>> 2. Will be there also in future.
>>>
>>> Make any architecture existentially relevant for and not too much
>>> coloring in the text that is easy to check.
>>>
>>> It is nearing 5k lines so you should be really good with measured
>>> facts too (not just launch) :-)
>>
>> ... but overall I get your meaning. We will spend time on this sort of
>> documentation for the v10 release.
> 
> Yeah, I mean we live in the universe of 3 letter acronyms so
> it is better to summarize the existential part, especially
> in a ~5 KSLOC patch set ;-)

Indeed, thanks.

Ross

> 
> BR, Jarkko
> 


