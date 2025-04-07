Return-Path: <linux-efi+bounces-3216-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0BBBA7E952
	for <lists+linux-efi@lfdr.de>; Mon,  7 Apr 2025 20:06:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 554EE3ADFA7
	for <lists+linux-efi@lfdr.de>; Mon,  7 Apr 2025 18:04:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 296102192EC;
	Mon,  7 Apr 2025 18:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="JEKlZeQX"
X-Original-To: linux-efi@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2071.outbound.protection.outlook.com [40.107.94.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F1A629B0;
	Mon,  7 Apr 2025 18:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744049110; cv=fail; b=SrgcZ22s5uXzBRY9WDG+K87wl1JO3ULNs045/fvR6Zlf/OHGfdqkVtGd0dy1AVvoRUeEheMPF0H5aNGkkYMDjmnSBNFdowesXD+P7h5FnhKdCV5yk8v57lYl0W1OEfXCd6RevDyLu4kNthAiJNXzpNOA8bn9Fts5nlHqv10FWdY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744049110; c=relaxed/simple;
	bh=OYiPBucOJiUfT2MOIwdI4jdRBPWoysNvtDNCUi5IICE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=b12PpHHCuMrJiAQERIZOJcGhvD8T+J3+5O9T8czxT7jQ3maeQC6bz4TdaYL4ZQxRtKojKhZFU3T7R+ouklg3Hwjv2rBp/d5VEKfVDIDFoELbvpzKby+PwVyCuH9sf/q7DqZxQtleQ3aZl4sbtDmMoeccoTGGc+uS18ffVixEb/Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=JEKlZeQX; arc=fail smtp.client-ip=40.107.94.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QIea3/kljquSzmUgxjH0BsMEWSn67P5IBhiBbtHcQfLCLY+CQud9FEaeWo3hg+u2kNA4cXu84/8GEJpjba6/M38KD39gvUvmiKd9ByP0qgUvYV5wooVAT6Y03q3v3EwSJVmR3AxAn0gm57wwZESGPvDx8sB4JhbfhCZBPDqOvyUMHCAYbFvgm1/q+Y2wt9R/9hDCrCjD7loM5O1IbbrAgYVadiGOxauV04wi67lqBZywTCqntiQwRiKlIo+Tn1mHDDoKO8T8gisS3bBmGybQQ1cswxBLL16oX6MkLeMGRKXTxII7bg9o0uJ6yltwxp/z0KBgbfXSaJ89KFzOvjIjKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SWshpPCG1IihApF1kktUt+ajZ3Xr4HopyfyQYN0pwyU=;
 b=bgTlfHIBNL5QjMfjefUfUcQJJ9as6O7jPFFZVObZgVNYkY3eeul1Mhni+2Oe7Pn8+FZrJB4obF2SS/jcroHYIbjkyJp/ef5eIsyLDqz9LKCu3OlLbaIOjZekDJG1FwdEWaNDBN8NVuCZ2vpQ3hghfT6qbz5e/21QYRqzKih2e/03Xh44g3LryxPqpHUonL2hbHJcdPRHfhWpYellFfcfCg66k7COEETfPLMVaNcsJw1W7j2/so/li96NFniCPehP4ipYCaIL/84KOaTRLoT8oL0AU4rgXb0GqIGr5Ol5qP3N+ZwlRXlgnI2HGyOH2egbCNwyoyZhIiBDcPAnNzF1/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SWshpPCG1IihApF1kktUt+ajZ3Xr4HopyfyQYN0pwyU=;
 b=JEKlZeQX8ps/O8cvxxwtzUayEhum0Qfaj75qXUXFZUCMH8hAj+kLdl8CEEjMLMdDePqd8ZrF8BtZVh0yhc6Ytoncuc0rcSfKW83IeKt+VcoF56a50VgqdYjyoj84vUWNbU4Bopn+rcLRXGTxKQQQbfsNWv4/RLlxawrc9RBhuyY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5070.namprd12.prod.outlook.com (2603:10b6:5:389::22)
 by DM4PR12MB6591.namprd12.prod.outlook.com (2603:10b6:8:8e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.27; Mon, 7 Apr
 2025 18:05:04 +0000
Received: from DM4PR12MB5070.namprd12.prod.outlook.com
 ([fe80::20a9:919e:fd6b:5a6e]) by DM4PR12MB5070.namprd12.prod.outlook.com
 ([fe80::20a9:919e:fd6b:5a6e%5]) with mapi id 15.20.8606.029; Mon, 7 Apr 2025
 18:05:03 +0000
Message-ID: <9f689ba2-add6-cca2-e7b3-fa0393fe2b98@amd.com>
Date: Mon, 7 Apr 2025 13:05:01 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v2 3/3] x86/boot: Implement early memory acceptance for
 SEV-SNP
Content-Language: en-US
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
 Dionna Amalie Glaze <dionnaglaze@google.com>
Cc: Ard Biesheuvel <ardb@kernel.org>, Ard Biesheuvel <ardb+git@google.com>,
 linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org, x86@kernel.org,
 Borislav Petkov <bp@alien8.de>, Kevin Loughlin <kevinloughlin@google.com>
References: <20250404082921.2767593-5-ardb+git@google.com>
 <20250404082921.2767593-8-ardb+git@google.com>
 <l6izksy3qtvo6t6l3v44xhuzmrnl2ijv7fx5ypvaz7kjxvpwhh@4zwlvxyfrp43>
 <CAMj1kXGwnTkb1bUDaRpkh3ES8thcUVQE7+qgfZQw+RORtvtv-g@mail.gmail.com>
 <CAAH4kHbxMDGQy3v9ef1ZdqK0TNzpm==BJgx1KiUpRP-CRKDx4w@mail.gmail.com>
 <ldrma6tce2bwhenu5kobjzvk7cz445ubfmpcynwadqudgvzuh3@aibigcdzui6m>
From: Tom Lendacky <thomas.lendacky@amd.com>
In-Reply-To: <ldrma6tce2bwhenu5kobjzvk7cz445ubfmpcynwadqudgvzuh3@aibigcdzui6m>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1P222CA0104.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:3c5::14) To DM4PR12MB5070.namprd12.prod.outlook.com
 (2603:10b6:5:389::22)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5070:EE_|DM4PR12MB6591:EE_
X-MS-Office365-Filtering-Correlation-Id: 7b460669-6c17-43a5-dfde-08dd75feb8aa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Ymk4bS9XVWozMGRQejF2a1R1MUNLVnBKTUVZbVpUaDJ6TlFNbStac2pKdUt2?=
 =?utf-8?B?a2xIUnhINUxKcGoxejlGVGVhYW5rcHlGSVRKNXUwakpzR1hkcHg5R2FZSjVz?=
 =?utf-8?B?MEhjcTdvS1NrTU1BQjBDdEhJdXN5SXhnT2RmeG0yUUsyUEVDVERjMHZZUTBi?=
 =?utf-8?B?RlZGdWxBL0swc2tXSU81b0YwdGtDMFNNYWw5V0RaenBVZFF4R1Mwd2JYMmJ4?=
 =?utf-8?B?OWh1UzZ0Wm1pZ1p1R0taZllRdVdjOWh6OG1vWktUSjdTSW4wRmxMdWdxNkdv?=
 =?utf-8?B?ZGtJU0lzZWdsbXViQ0V3eko1aU03MWlOaFkyRmNsci9OTGg3bXhnZ3R6K3ZH?=
 =?utf-8?B?TFd1U2Z5T1hNdHpzWTFPRnhhdXMrZlZSTml2ZTRFSzdoNkFvOVJvYmU4R3FP?=
 =?utf-8?B?YlNDN0o0Qjk0Um5OYlF3NmM0WjlwSjRJK3BuOTZMeVloTmxGWVNEWWEyVTVL?=
 =?utf-8?B?YVJ6VVFDOWIyK2RSeDlOQW45OExzRkRhUmYwVktxSGxZQW8rRkt5bzBvN0ps?=
 =?utf-8?B?ODQwTHlvRHFWd2w2bEZBM2JWQmlDRWhlMTNSRmJYYlpWbFl2WWVnbTBMa0hk?=
 =?utf-8?B?WUd4QWJOY0xiakV1b3JuSFBDcXNyMVNVZTZjYUdNaGo4eWhCdStCWGozNHF6?=
 =?utf-8?B?YTlnVUJyUG1IbmRKUGVaTWVCT2x0TnN0T2tMWjczRXBGVFhGY1hPcnhQaEFS?=
 =?utf-8?B?b1ExVS9WcTBvaE1EUHJzUVZMUUVaZVEvNWhRVnFud09vbUNmaXdwNEpaRTAx?=
 =?utf-8?B?Q1BIbHQ1VFBkaXZXbkdYbFNPaUl6ajF0NnJmQ3hYdDBENmtPRXdpNmRvM1Va?=
 =?utf-8?B?VWlZZUFacS9RMUZ1TFdodVNFcGU2akRucEd4VzcvcHI5RkJqa3JRSVk2Mnp5?=
 =?utf-8?B?dXc1TUhnUEEyeGRJcWRWNk5tSkZ4UHhFTjd5ZzFZdThMUGRlZ2I5aHFTMTZp?=
 =?utf-8?B?ZW04RVJQN2J1d0UxWEZnR08zaExDd21FK01OU1dDK0UrOVJaYk9WdTUycm9H?=
 =?utf-8?B?aGI3MEN5S3V1a0tSbmw5T0tZNkhjK00rVHRUU3hKdUVFVFFKOU9LRDhnMTZw?=
 =?utf-8?B?NkZibUIrbHcvT0cwWStnMG0rbld0clJjNnR5NDcxSHFuTlNCT2N4U2FZcWQy?=
 =?utf-8?B?bnNLOHNzWmkwSXpUMHhRVE5PSFRxQ0liOHFMT3pTblBtSllyeGtrTXQyeVVB?=
 =?utf-8?B?bzhOWVlkbG5vU0M1SVlqSEVpa1BPdE9wUnJuTGFETjV1Z3c0UXRkemVvNnBx?=
 =?utf-8?B?dGxHN0VBVmlxRnFRZEZncWZWaEcxa3hOK0tyYUdKdnVQSFVOQUViUzBENEZw?=
 =?utf-8?B?Z05oektrejRQRzQyaFNqeEtrV2pJT01MU2FONGVuRkJaSWZraHZFdllBREFk?=
 =?utf-8?B?bUdPYnVlcjJGVTVEUkJsR081OHljQm1HUFdESWxzM240MStWVFlYSDF4eC9W?=
 =?utf-8?B?RUtQN25wRmFUUm1PUVpqWGVFQlhvalVlb3FkUC82WVVkaURsdUVXSG5UZmgr?=
 =?utf-8?B?VHhSaXU3VVJYVnJlak1Pb1d4azdVRzcwL2tUL3Y3YjZycWp4dkkwY0JCUUVr?=
 =?utf-8?B?VTBWM0hNWlovK3JrNWpwSG5GdUtKWGVvcnBnd3NqOS9PTnRZRVN4R0M5QjMr?=
 =?utf-8?B?M3dJS2kwSmdwaDhLaWJMTWhYbUdSK1d6U1l5UTNPd2R6bWtPbTZFOWxzcmV0?=
 =?utf-8?B?dWp6Z1drS3ZwcnlTek42dVZ0STdNTnJ4ZldBU3RpdlBZR2s3UDB6dVZQekFi?=
 =?utf-8?B?M1JPOG9uSWRISU9wMlR3dW1KMmVYNEJpY25qRUxmZEhKZ2J3VE5SbnQzbGxj?=
 =?utf-8?B?S04xdisrUW1DaU1rV3RFZENoY1Z4QXpmR0prMVRObThGVEdyM04wK284QS9j?=
 =?utf-8?Q?vukxJceDO1qxP?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5070.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QUJtYytVSnBZYkFqTkxtNUhPclR0ZkRhMHpud2J2d3MrdzNlRFpaQkRtcWNK?=
 =?utf-8?B?alRJdkREb1VyUjg2U25pa1B3dFQvQUc4bXBabzYxaVk3ajNFemluNjNEZHVL?=
 =?utf-8?B?cGJWbDhjYXZmYVM4Vkd0RDVOc1VUQkR5VThORnBYalp3cjc1ZmxXT2RHOFpX?=
 =?utf-8?B?Y1hLZHJDRFB3aEtsSHhIODBwbkZCNXJhYzZCVmY1OHVmeXdpbVZESnJPb3E4?=
 =?utf-8?B?a3Zld1NJZFNaMDhza0FjOGlyZ2ZJdFhnRXVVNDBLc3l1QjBDVGZ0WTlIbW5C?=
 =?utf-8?B?bTl5cjZoN3pzdE90UThMSWZ6RzVWaTN5WUdzdVZNVkNMblhRVHQvdmM0ektK?=
 =?utf-8?B?OXlZQ0VPeTFQb1pxSGU5Vk8rc2dSQjRoaVhOdmlVK29nSWxxN0hKcFdOZGxP?=
 =?utf-8?B?NEp5RDZEL284NVVQcDBhYlNIUE9LVHE4Zlh4Zmp4RGgySG85elA1MzNKNldk?=
 =?utf-8?B?ZXJNc3NocFBEbVNjY3dxTVBFNUU0MDIremZ4c1UxQ2V2VG9UL2R1Q2kvTHFK?=
 =?utf-8?B?SUNxR0x4Ry9YSmxaSHJOQy9UeG5MNTU1cXZ0cGl3eGFodE9lWW9IenloUW54?=
 =?utf-8?B?VGt2SGc5b1NtZTUzcjVpUkRmTEpEWlFMM3dCRXJ2Z2ZrK1ZJRGx1SWk1T05Y?=
 =?utf-8?B?ZHRjQkNRN2RQdGpzeWJTYVhoZ2o5eGhvaS92WGd0VkxseDU0WFFkYUpCSlhV?=
 =?utf-8?B?YUJnNlhncmc0eEkyMU5KUGFUZElaSnhzM1Y5M2l2QjBsV0kxL1RyeFcwemFy?=
 =?utf-8?B?TDYrSVY2eGp0K0E3MkZ3NFdQa2o5a0hIalBxTUl0bmh6Ni9aeHVzdWE2bnZH?=
 =?utf-8?B?RXQzc2pvSXRWeVRsSkVwdHlGbHNPNC95b0w1MjdyeFZHNTZybmc3TmdHOUlS?=
 =?utf-8?B?Z2pIMVdYZFJpNVFFcEVOTnYrZWRZYmxaZlEyaTdkZzdodWFmN091YktDL0Ey?=
 =?utf-8?B?cEw4dzlTVnQreS84UFRwMHNjSTZqVlJYWjBnbU1JS3BaSU9uNlNIZ3ZtRTRj?=
 =?utf-8?B?WlVBNWVzWUUzTGFyS1R2eUErZmpQc2RIUE1KMjk4Zm16VHBGbzB2SXhEMzVT?=
 =?utf-8?B?NVNTc1AvTW82cHZSRTl4OHB4SExvWnBTbm9uOXVVdm1BMzJLdS9LRUVaVHZ1?=
 =?utf-8?B?NWNXczZXT24wWWwyamJ2dXdvZ2N3MHhWMFByQkhhVUpPWW15NVo2cGxTOTI5?=
 =?utf-8?B?NmdRYWRzMkVrSUxHNVVicjczWXo2c3FlQTdhTGxSd2xLbnluQTZqL2IrMG5x?=
 =?utf-8?B?SFRBTmNwdWVwOVdKTVpFYzJmbzJHTjlHV21zSnRQOUtLN1dtSmFZWXExOVhJ?=
 =?utf-8?B?bG8rOTN2RWdEdGRWVFlTeTRyQTJxbTNwR1VQVE9SVkhrTTVCUEtTQ2lnbWZo?=
 =?utf-8?B?Zmk5YS9iSGNsczBSa3RQMm9uN1FyT0QrZmw5ckJFZ0psZTJJOU9JeXhsa2xP?=
 =?utf-8?B?L1BxcWxlcFp4dSt5NytUcVdMTjRZeCs0akQ0L0RxVWN6VTMwUXhMaS9ZZlJy?=
 =?utf-8?B?eWY3WFh2cVlvRDZsVHRUZHJTaVJvOXgrNzZxMDVkR0c3RVBJeFAxNjRlK3Zn?=
 =?utf-8?B?NXZKMTdZTmNDSjR4VlFrSXNaTGpaM0JGa0dPdDJUNzlia3VsRXRkR0xzVFBT?=
 =?utf-8?B?SzI5TnJ6QlJ2REZTTVRLM3g2RGhCMFFaTHRLMmpPTllSUERlYkpmRXFONGFo?=
 =?utf-8?B?aWhuVGlBS2xuWXd3Uk5pam85YzNhYk0rYmpBaGJrQ01aMHBlZXBjVlNocGlm?=
 =?utf-8?B?QTVHRnhjUFAzZEIveTU5cmFYdHIwc0F2MTNqYjA3amZUR3RHSjdFR2pETUV6?=
 =?utf-8?B?eEdvRmtEeEE3ZW9kY2VHNDU1dVhySVlpQi9lZEpYeTJDQTg5MFhaeGZyeVAw?=
 =?utf-8?B?R1lTRGpXNGRWSmtzdkpzN21WUnlBNWU1K3hNcS96Wm9pQlcrUzdNc3hQNURM?=
 =?utf-8?B?WWhMUnNoMFRoUXV0MzkrTENrUmdwTmdrNjJiOEtXWmtjR1ljQ3g4WGoybUdx?=
 =?utf-8?B?Q3VWZFQzM01EenV4ZWRLK01MVTdhakZES3Nla3k5RG02SFlLTTVrd2c2ZVNi?=
 =?utf-8?B?VUN0WnFuV0Y0YlJDWmRaWjZVdjZ0MzI4SE5nOXF2YmZncnNZdno4bmdpbWd2?=
 =?utf-8?Q?OlHG84u0jQBulgTcHx/BKoI4w?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b460669-6c17-43a5-dfde-08dd75feb8aa
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5070.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2025 18:05:03.8654
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T35fUZdaZDjrSBnWfta6VgM3Mi0hgRSXWdShn/3TnRxK/+4LpWonTvLGDDzKDWHmqsSsRBpEgWCo5WFuf0ra4Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6591

On 4/7/25 04:25, Kirill A. Shutemov wrote:
> On Fri, Apr 04, 2025 at 08:07:03AM -0700, Dionna Amalie Glaze wrote:
>> If the GHCB is available, we should always prefer it.
> 
> I believe we should consider the cost of code duplication in this
> situation.
> 
> If the non-early version is only used in the kexec path, it will not be
> tested as frequently and could be more easily broken. I think it would be
> acceptable for kexec to be slightly slower if it results in more
> maintainable code.
> 

Is accept_memory() in the decompressor or efistub only used in the kexec
path?

Thanks,
Tom

