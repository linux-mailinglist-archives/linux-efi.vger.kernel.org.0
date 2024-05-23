Return-Path: <linux-efi+bounces-1078-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EC0B8CDBD1
	for <lists+linux-efi@lfdr.de>; Thu, 23 May 2024 23:20:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 730061C22C35
	for <lists+linux-efi@lfdr.de>; Thu, 23 May 2024 21:20:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E236784A3C;
	Thu, 23 May 2024 21:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="3wHhJb2G"
X-Original-To: linux-efi@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2053.outbound.protection.outlook.com [40.107.92.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E15352628D;
	Thu, 23 May 2024 21:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716499197; cv=fail; b=sWm7CMcfBiY21qnQGL6n0pOJ7Jow0sSblNv48vTSkza4HMkz1llWDM0yZcipRTbfuyA6z0oS0Et5qJBCgpvdW8ELUeJafIaeCCPqmV7O3eIvrGykVKrbauCv8ObIQ6ReAEkuw8h2F0tHKCnjmU5BNzlXI6XuDgKuRWalwaPtL3E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716499197; c=relaxed/simple;
	bh=R07fKPmoN5OCdUc+Nx611yV3LHG07bvSHZM+JapzkvA=;
	h=Subject:To:Cc:References:From:Message-ID:Date:In-Reply-To:
	 Content-Type:MIME-Version; b=IUfEGXDFsFPiCAYJ0Zl/fcstliEExGk7AoAGwgF0MbuOlH/xnYn42BDwtIsk9KAErNtrBQm4d6Td5DZhbkmXP3n8okL8wxC3ODIJZONHLR70/LAMBQ9Dvm/QLRgNz9Bkj8cmn2ub9CVp7AhoCD+Y1BAn4B5LRfe9Byj3vdz+Ngg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=3wHhJb2G; arc=fail smtp.client-ip=40.107.92.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MNrSCn93quSLL7vqzmHmlqJFbljj8AnzZlu0ZnPB9MluXM+8qZcQW+gRXeJbXvmv9qZVV83dF6BlSIfmsNDEtH3sb3wyf4O1pjf9rSXgn0VpXd/ajKIH+jK6eCbIiMynUANblHuIu/BeY/475XpnPuw/aZtYFqQEYhyqmghAVVx26i9r5bMcN03CNEvtjDlzXZu+P7/KkavVnqRe2TaOB5WuX4fMavcUqIa7KjnUvLb+Hu8h0aVPNcuZY8pqkIlZsnxnnsT457TCCAQqyQqnfSeZdLzlf7bF4c+klVzGLFbaqancUUiDBSJTQHo2cNuyFer7j7ilgozH5+ycphlAiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wfzsZncKULP4pPk0cUH3ce4XYKgD5M6FwqraAJe9BSw=;
 b=WpnhWHb7sUuBwxl7SMowayeiNUXVkN9c3bj2lzI1zyNn8pSdhzVpX2oRSjk/LplLtTsks1myAOV1AD/3fdwEOYI7vFKRDK6YD8S0WDsu7g2zqC/ca9/od/bTNTMtb2d0qZMQ0GoZ8JFppN1a1xN4cx28KzxqrAO01cQ0HsgdASqwvQzGUP3SBjrUE3rNz+DbZ2jpXUMGhZDqhEiPf2D8OTQjougPa3kFghaTAwNCH0JX+TvYFyJLlOuQ4e74LIq3TuPDe47t6cMjXz0Z8luJ6i58TIEr8ixDKrmsWpCHJdOYiVi4bEtTOQfCRyjqB8hMctSm4OsAFdDRsv/MOMM6sQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wfzsZncKULP4pPk0cUH3ce4XYKgD5M6FwqraAJe9BSw=;
 b=3wHhJb2GMv1v+sz6tjIffeZElDY0xU9Yr9HPmIOsaTk3V2k3eQcxg+FXoNhSpjY06marM49UoSRV1Nl6SuYLVLkTDYn+AhzfxvP8HrtsgrThxa0cdRUGwd3bXs+e+LBMaRjj3QdAzaN3PiFTlEpxreIUZjXfLg/Y03BlDkk9954=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB2869.namprd12.prod.outlook.com (2603:10b6:a03:132::30)
 by PH7PR12MB7329.namprd12.prod.outlook.com (2603:10b6:510:20c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.36; Thu, 23 May
 2024 21:19:53 +0000
Received: from BYAPR12MB2869.namprd12.prod.outlook.com
 ([fe80::56a2:cd83:43e4:fad0]) by BYAPR12MB2869.namprd12.prod.outlook.com
 ([fe80::56a2:cd83:43e4:fad0%6]) with mapi id 15.20.7611.016; Thu, 23 May 2024
 21:19:53 +0000
Subject: Re: [PATCH 2/4] acpi/ghes, efi/cper: Recognize and process CXL
 Protocol Errors.
To: Dave Jiang <dave.jiang@intel.com>, linux-efi@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org
Cc: Ard Biesheuvel <ardb@kernel.org>,
 Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
 Dan Williams <dan.j.williams@intel.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Yazen Ghannam <yazen.ghannam@amd.com>, Bowman Terry <terry.bowman@amd.com>
References: <20240522150839.27578-1-Smita.KoralahalliChannabasappa@amd.com>
 <20240522150839.27578-3-Smita.KoralahalliChannabasappa@amd.com>
 <8470dcc5-fbd4-4977-b8e8-5f7bfbf4b220@intel.com>
From: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
Message-ID: <08dc0027-371c-5783-fd65-ad6f8b228fee@amd.com>
Date: Thu, 23 May 2024 14:19:51 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
In-Reply-To: <8470dcc5-fbd4-4977-b8e8-5f7bfbf4b220@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0132.namprd13.prod.outlook.com
 (2603:10b6:a03:2c6::17) To BYAPR12MB2869.namprd12.prod.outlook.com
 (2603:10b6:a03:132::30)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB2869:EE_|PH7PR12MB7329:EE_
X-MS-Office365-Filtering-Correlation-Id: 3caf55aa-0541-4813-3c9f-08dc7b6e163e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|1800799015|376005|7416005;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?b2FpejBrN1RKZ3ZUd2NGNG51eUZsNFVEQjBlY1oreUZxWDdvQnp1RTZVZGlw?=
 =?utf-8?B?UkNjVlVGblowRUxBeTlVQUdjbDZBTWdMVVhSOWRub0k5QXRwOGd4Rk1SUHd0?=
 =?utf-8?B?eGdQM1RCTzRLZlU2Y0VYVVdBRGY3N3VPNytlTkZpK3RwNktoZk11QkZTeHIx?=
 =?utf-8?B?UTlkZVU2dnJyR0UrWFJNdFhzOUJzOGdQREFpWGZPWXBWdWZsWkJhc0g4Z3U1?=
 =?utf-8?B?OXN5VDVLNFBDczZvNWxMYUhVY0pjMTVudEozRE52TVhNOFpPQmhvQWJxU1lQ?=
 =?utf-8?B?UHg1MHJObDZZVWM0N2ZYUzVqckQwUkt5TTFIY0tMcThlSkhPaUN6Q0kzdzBz?=
 =?utf-8?B?K000L3pzcWZZdm4rbURoSUJXUlF5ZlBEd1YrWWMyN2cwS3Q5cVNjV2NrWjV5?=
 =?utf-8?B?QmdCbHM5dm5kYXRTMERWYnQ5NnBmc2RGcWhLZytmOTFkazExelV4MXdXdENx?=
 =?utf-8?B?TEdkS3RTK0tkeUowVVFLSnhnd1VxY21jTndmS05hTEhrYzIvRUhWUzJybTZw?=
 =?utf-8?B?M3NnZGl2bSt1WktxaWpoN3oxVU1Ya0ttZ2RuRXdxZWRSYXFGWXBYUEh1UTRZ?=
 =?utf-8?B?VWdxRUVwaWhEaTZuRVlybUhZT3RVZEFZT2xkaExBeTFRa3FyTldXQlIraXRT?=
 =?utf-8?B?OWJJM21MMzE5RGhSek9qUHdhV3hreUwwSElQQjJwZDNTUFNkcXJLUGFFbkt0?=
 =?utf-8?B?VFdOK0JaWExmdExHN2kzN0tvSlhGQ2ZoK3dtMlYwb1o4NlFCNFRuR3dHSzNL?=
 =?utf-8?B?Nmh2b0dHZmZRRmdpeUswcUlIYndJa25QeG5sUHNKcmFTaCt1dDhuR2JFbmE0?=
 =?utf-8?B?akU5QzJJYWRoUU0zbXJRTEkzSzdoOWVFczcyK2RvR0U3c3ZiWUxwV29iQ1l5?=
 =?utf-8?B?ZGVrcXlUTW9XL0wydlpyUTlMUWJmQ3BMY29xQndlUHgvQ0R1WWhWMCtualNX?=
 =?utf-8?B?Z2liRHIxQm0zY3JZQ1pPWk05b0tnRm0zSy9XeE9lKzhzTGQyTld4OWJGdldH?=
 =?utf-8?B?UkJPcCs0a1BHeHZtMkFraGZlMlFaNytoMkJpbUZIQzVyNnY5QldCeXR3UlFa?=
 =?utf-8?B?eVJHa2MxbXNsVzlzZm8vY1czU0JibStGOU0vYkRyWWZnZUVXalAvZkNYRzZQ?=
 =?utf-8?B?SFBMTVZicjg2b1VpbUNFRTYwK0ZRZlZZNWY2Q0pscWI2WWdZd2ZmaVYvUDEx?=
 =?utf-8?B?VS9tZE5JcFFMVURyK2xFMGJsTjg3bEdrNnZXRGFSOWdQOVNIbldzREVZbHg0?=
 =?utf-8?B?V1dFQTB3dHpEZTdlRVdMb3ZKWURhWEhCSDVselJmVzY5dEVYWUZLOFFrbVVF?=
 =?utf-8?B?RS94WlVLUlBBYzlZUTlaem8wK0RFc1FtcW1Yekh0UHRocmVWaFpDVERuZ3VR?=
 =?utf-8?B?Z1k5ZTJzVlBMUXhRd3dHNVVSN3FPTVB5SURSdTg5UWlwNGlQQTg2UkRjVU5X?=
 =?utf-8?B?MjU4RmhvVG04RDJvQ2JEOXRRQzVtZUxjcUZ1S3NJRCsvVUlBMHVDYkJJNFZH?=
 =?utf-8?B?NGtEUGR5enMvK2IrcCtVQ2wxWUZmbnhuYWprQVJ6VnNHejcyR1ZTU1BFOG01?=
 =?utf-8?B?ajloa0xRVUxrZ1VaV0I5T0k0U3k2a1kwU0RlSDFxMzIzYXpDY1pVYm9tZytu?=
 =?utf-8?B?ei9keXpHUkJIYm1PMzBWdHRLV1paWWJIV1dvaExmdXdOaWVhUEtFTU5KWk1a?=
 =?utf-8?B?RU5ybkVjdTAveTczTk9GSUkwdDJqVCtNTTVnWmh2eWRIMmtvbEJWV0dnPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB2869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005)(7416005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MzYvdVFIYmE3dzNqZU5qNkFmZ2pYTG54dHQ0N2ZhTXlyWjJveEFpQmZ6MXVo?=
 =?utf-8?B?dWcvcTdWSGdGVmtsSE1BYjI4K0JCaTUvZk5tQ0lKcThVT3A2ZmpEakgxbmhp?=
 =?utf-8?B?dUFtWDdyLytBbkYzWXVWZDJLUldsL0VxSTA1eTErdVVRc09FNlQvZ3lmd3d6?=
 =?utf-8?B?MjNzN3RKMTBaSlNzSGMxWm5BdHRTTUNUMUZFczc5NVVwOTZ3YnFzT1BZT2c2?=
 =?utf-8?B?YXE0MXFSRFNyTkhaUzBRMG0rTkFpblVrcGUxajhnOE5idVM5NTNvZWVzeXNC?=
 =?utf-8?B?dVBBQjJmUU9LQS9saTdPYTdFU3JVc0VUVnp0K0ZnR3o5V2QybW9TUDVIdXlI?=
 =?utf-8?B?bmRQN3ZCM0ZIL1JMQU1hR1ZHY3dhTlczZFlRempPMmJwVU44ZnlmWTZ6dWFT?=
 =?utf-8?B?ZlhCK2RUcHRYUWRTTUplMno3RlYzMWVOVkQxZGdCc0pDOFZMMUMreHhNZWdY?=
 =?utf-8?B?NVFzUDd2NVYvQ3V1Q2ZJZkExTm5yZkI3OUY5Q2poOUlZNXVKYk40MzB0cmkv?=
 =?utf-8?B?bHhhUXRZS2d0VDFDMEQ5RG5scyt1QzIweEVIamdKUUFiSVY3WHlKdkpmTGFM?=
 =?utf-8?B?cGY3WGdpSmZRaGd3Vjh6NzB1Q3BzU2RFTGh1bDZ1WGh5b0tkRkhWZGFSNE9P?=
 =?utf-8?B?NjhNNVp5czdWeTZNVlFxOW9lRXA5QmJOZlc4eHZHdnpFK0NhMS9qV3lIWU5W?=
 =?utf-8?B?MHFVbGhhbnZKcVJ3Q01wODhYSUFmQ3FHK0ZGYi9yMmhadHVJK3NwMU9wdXFl?=
 =?utf-8?B?YjNXRkpXOVZvN3JmZVVlbTdOdzRkVzJoT0RaVkRONnJyVDYwdTRyMkxHV1FR?=
 =?utf-8?B?Y2ZNUzNxdmhwQVV1TGtYdjlVYTFHVG5GNmVrVGcxeWVGU2k3MjBnWDNIRUVJ?=
 =?utf-8?B?Y0RIc3NZWFV3aUJDeHlJM3ZaSEd4cmNQZC8zU2djeHBiSDBaTGVyVEhRWnYv?=
 =?utf-8?B?NDJyTzhTT3NkMGY1OC90OXhEaTlRNks1blgxNGZqWG0wOWNKSFlHMkxnWDRk?=
 =?utf-8?B?cDZWeUxsc0o5Uk5aLzU3cElEZWJlQ3NnemhQR21kYXpOdXU3UjhxbVV1Mzkr?=
 =?utf-8?B?SFp5Y3dvM09ObFY1N2RNRWNpWEQxT2hOcGZpa0Jia3NjRVBIUTc5NW5iYzg1?=
 =?utf-8?B?Y2hnbDdNZ0pQWWc5dFJVV0ZkTUVCWTF4RkdpdkcxUHI5cDVZT211VnRRMTgz?=
 =?utf-8?B?RklpaGN3MTBIZS9UNHlqNHBIcnNjVkpvdG1VWDdSQ3Y4THN6aHZOZmJEN2Fv?=
 =?utf-8?B?dU1uVlMvL0NuOUZnOG9JSHlRU01NRTlsMjNkb2crOEgyTTMzeXV0dHNHTWE2?=
 =?utf-8?B?YTNoZkxNQXErdTdyY3VoS05WOTB4NGNkNURUdnZZOGNLRnFibGdWdEphVTZG?=
 =?utf-8?B?NXRRNTJvRE05ODEwSWx3NytOUVh2SU85OE1WS2lnZ3RJR2hPdTArd2hwN2h3?=
 =?utf-8?B?aENqUTdzcURScmRKSUVXdi9tNW05WEtWNk9hN2FSN0gxc1E5S25ZMFBjWklT?=
 =?utf-8?B?UWtxUW5Cb1VDaVc5dDFzWkhMYndxM1hCMGoxZFphTDdVUWh4NHo5UXRCcXYr?=
 =?utf-8?B?aXk2czIvV0trVTJ3U2cyOG9ybWtObzU2OU9BaGJrVHczRjVvWm9Sd3RoZWRS?=
 =?utf-8?B?MlBWeVJIVTBJcnBlSG1BVlp6Zk5kZ2ljMlBvdFNCd1JmZStuZ2RXU1JFRjZj?=
 =?utf-8?B?cTRLK3JvWlVwZmhSVTg2VXBzYUR3anlvOGl1VURQcFV2TEFsTzRqV1BTWGZn?=
 =?utf-8?B?eDBacTNndkNCcEJhWDNFMnpIUTRNSUlVeW1lUTd3TG5lUGlQVFJtMnpDY2po?=
 =?utf-8?B?TUQ1REhjc2I5bHQrUFY0aExIUjdZcVladDg4cllPam9OSWNISWJyZWFHS2R5?=
 =?utf-8?B?a2J6QkM0R2QvNXE0MEJXR2E5QTlQNHRRT3h4dk12WDFnbkVPM0lsNTZ3Sko3?=
 =?utf-8?B?eTIwdUhyZ25ScHNOY1J0TWdDUi9nc2I2dlJQVmhEOW9xdE80cFlUa1VTaTFK?=
 =?utf-8?B?TURJUi9zYk9tWmYzMFoyTkQvSGh2bHlvTldINS9aQWdITCsydmorT2owaHl4?=
 =?utf-8?B?NXdUd3JZVVhKYUt5UWlNbDNrZDc0M1dTc2tLSXRPMjdsYy9rem1XMlJRYjl0?=
 =?utf-8?Q?bed1snRplZvJu1eHLo1weqyz+?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3caf55aa-0541-4813-3c9f-08dc7b6e163e
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2024 21:19:53.0624
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qui553IDAvSr7ooo4FKUvmk7dLWTupXfAygNr0l9o+Mp11zNvNEZiuZYHv4pYMRQv1LHe+Uf8ibSabyxwxtCDw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7329

Hi Dave,

On 5/22/2024 10:59 AM, Dave Jiang wrote:
> 
> 
> On 5/22/24 8:08 AM, Smita Koralahalli wrote:
>> UEFI v2.10 section N.2.13 defines a CPER record for CXL Protocol errors.
>>
>> Add GHES support to detect CXL CPER Protocol Error Record and Cache Error
>> Severity, Device ID, Device Serial number and CXL RAS capability struct in
>> struct cxl_cper_prot_err. Include this struct as a member of struct
>> cxl_cper_work_data.
>>
>> Signed-off-by: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
>> ---
>>   drivers/acpi/apei/ghes.c        | 10 +++++
>>   drivers/firmware/efi/cper_cxl.c | 66 +++++++++++++++++++++++++++++++++
>>   include/linux/cxl-event.h       | 26 +++++++++++++
>>   3 files changed, 102 insertions(+)
>>

[snip]


>> +	 * The device ID or agent address is required for CXL RCD, CXL
>> +	 * SLD, CXL LD, CXL Fabric Manager Managed LD, CXL Root Port,
>> +	 * CXL Downstream Switch Port and CXL Upstream Switch Port.
>> +	 */
>> +	if (prot_err->agent_type <= 0x7 && prot_err->agent_type != RCH_DP) {
> 
> Perhaps define an enum CXL_AGENT_TYPE_MAX instead of 0x7 magic number? Otherwise if a new type is introduced, it would break this code.

Agreed. I will define a boolean array indexed by agent type as suggested 
by Alison. That would avoid all these comparisons and not worry about 
breaking code in future.

>   
>> +		p_err->segment = prot_err->agent_addr.segment;
>> +		p_err->bus = prot_err->agent_addr.bus;
>> +		p_err->device = prot_err->agent_addr.device;
>> +		p_err->function = prot_err->agent_addr.function;
>> +	} else {
>> +		pr_err(FW_WARN "Invalid agent type\n");
>> +		return -EINVAL;
>> +	}
> 
> Up to you if you want to do this or not, but maybe:
> 
> 	if (prot_err->agent_type >= CXL_AGENT_TYPE_MAX || prot_err->agent_type == RCH_DP) {
> 		pr_warn(...);
> 		return -EINVAL;
> 	}
> 
> 	p_err->segment = ...;
> 	p_err->bus = ...;

Noted.

> 	...
> 
> Although perhaps a helper function cxl_cper_valid_agent_type() that checks invalid agent type by checking the valid_bits, the agent_type boundary, and if agent_type != RCH_DP?

Okay.

>> +
>> +	if (!(prot_err->valid_bits & PROT_ERR_VALID_ERROR_LOG)) {
>> +		pr_err(FW_WARN "Invalid Protocol Error log\n");
>> +		return -EINVAL;
>> +	}
>> +
>> +	dvsec_start = (u8 *)(prot_err + 1);
>> +	cap_start = dvsec_start + prot_err->dvsec_len;
>> +	p_err->cxl_ras = *(struct cxl_ras_capability_regs *)cap_start;
>> +
>> +	/*
>> +	 * Set device serial number unconditionally.
>> +	 *
>> +	 * Print a warning message if it is not valid. The device serial
>> +	 * number is required for CXL RCD, CXL SLD, CXL LD and CXL Fabric
>> +	 * Manager Managed LD.
>> +	 */
>> +	if (!(prot_err->valid_bits & PROT_ERR_VALID_SERIAL_NUMBER) ||
>> +	      prot_err->agent_type > 0x4 || prot_err->agent_type == RCH_DP)
> 
> prot_err->agent_type > FM_LD? Although maybe it would be a clearer read if a helper function is defined to identify the agent types such as cxl_cper_prot_err_serial_needed() or cxl_cper_prot_agent_type_device() and with it a switch statement to explicitly identify all the agent types that require serial number. If a future device is defined, the > 0x4 logic may break.

Probably helper function is not required if boolean array is defined? 
What do you think?

Thanks,
Smita

[snip]

