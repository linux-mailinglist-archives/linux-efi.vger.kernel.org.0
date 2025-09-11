Return-Path: <linux-efi+bounces-4738-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 35498B53DBB
	for <lists+linux-efi@lfdr.de>; Thu, 11 Sep 2025 23:27:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B4CC1BC5DD7
	for <lists+linux-efi@lfdr.de>; Thu, 11 Sep 2025 21:28:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58CC72D97A9;
	Thu, 11 Sep 2025 21:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="V+MytfQ3"
X-Original-To: linux-efi@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2072.outbound.protection.outlook.com [40.107.94.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A3BB2C2357;
	Thu, 11 Sep 2025 21:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757626056; cv=fail; b=ewYQZXAvwzWMuX8dF1GS40drv4LHVYI0/uwMDJzY9YP6eOeXxV2QiDa17JCZ74F98whzA5Knpyi48gK/iuAwwVzTFY+putYFGAD1/V+gJ+6A2ShNKpXgLHg3S3y7JVkhST3axNeVfL8MOSI4LNgpkZrLTT9AkLQBTEqAjpbhnY4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757626056; c=relaxed/simple;
	bh=YJGmrowHQYpQsdOIrOz4xgbafZfW3v+U4QG/aq3T0AI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=YAmyntS92HDrGKzz6aGZF8pOJ5JrIZoXuNlGG8DvPCDeVhg7oLtRWVCP51w+x0tcvWKUbczt78D4Jlb6fisORDZiEX5sFmiulk25mbkErp4qWeYddzIk7WEyTOm0emoPaybx1+2Yj6iG6VsruCqy0m7DBFA/tgyC+7xky5rTmTY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=V+MytfQ3; arc=fail smtp.client-ip=40.107.94.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XhYvGqaPZigGiLYr6QbfALWEq3eaDjSuqEqUGeotAwasARA9H3HILfMe1gxBn6Y0j+Lrjj4l4G1At3vySnLMDDsDWeYQujoNJ1jhbMNGCURCtlgnGHaGDYwarLFwB5cpiiNcWCMn0E3YZR/h/GNbUCxk4fYr/kkOaw1E85hqTx8X2st6DTj1Uz9WQTi76p9pJy2e4rXL6G6mkZSqbqSCi/+i1vjxwb6yJ2bmreB+QO5NmFmEus9ILk4oP7kDKTnzZHmAeo19tEBi6DpCjTe7VXEpBnRXyT7/GgfQL1pTLsD7LIYrOiJoEAOZWlWujtPDRchcfh0Gc6Jasj4g0o1ZOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RQeAp6c9O3D3RfiiJtmxNiFW29ulv+kUmotU735NpQs=;
 b=dyr7BxytbVNe3JCFqH0G/Pp8cxkRxxHYKuFSWa43+xrFjSpbfv6mRydFUIBOu2P9yLjoKNE4+IBbLOczAUE/DSKTiFlA/9d9pg4vRI5id+/7kGf2FGjZXr8v6jZChCO+YwE4f+59FUC358n6esgfXbKBxott04A8CUfp+mseI38/wryNcK4hnArBigJMzGubLkEytBr5LDLXrVgjWhnOcmUpsPQ2vaNAaObaKjnvZIuFlLZ+/xMjmmZwooMqyESORmQU54KkliOCCKXsKlBetiHgFIzXH5OR3HJJtgLn9ELmTnsG1ViHSIu/YoHk53dBEPE1G+C7cuN1MjyPqBg98g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RQeAp6c9O3D3RfiiJtmxNiFW29ulv+kUmotU735NpQs=;
 b=V+MytfQ33ikXaN6IVBWVyT+FyNO6sEweWjvNiVxfmH68Uw6H/+ZTtkMAmetBtRdN69z8hF31bKONwXLC+zJGOtK1rMcs8CvXLB7cxpznMIJJVoPE5grFIzgHfRZzwq+e31uVtAny21HZ1daglXELtZb17DGVCTImpJrXHKvJQLU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5070.namprd12.prod.outlook.com (2603:10b6:5:389::22)
 by CY8PR12MB8066.namprd12.prod.outlook.com (2603:10b6:930:70::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Thu, 11 Sep
 2025 21:27:29 +0000
Received: from DM4PR12MB5070.namprd12.prod.outlook.com
 ([fe80::20a9:919e:fd6b:5a6e]) by DM4PR12MB5070.namprd12.prod.outlook.com
 ([fe80::20a9:919e:fd6b:5a6e%3]) with mapi id 15.20.9094.021; Thu, 11 Sep 2025
 21:27:29 +0000
Message-ID: <2abffe1f-e289-4261-97f0-cfc4cf674fd0@amd.com>
Date: Thu, 11 Sep 2025 16:27:27 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/3] x86/efistub: Obtain SEV CC blob address from the
 stub
To: Ard Biesheuvel <ardb+git@google.com>, linux-efi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, x86@kernel.org,
 Ard Biesheuvel <ardb@kernel.org>, Borislav Petkov <bp@alien8.de>
References: <20250909080631.2867579-5-ardb+git@google.com>
 <20250909080631.2867579-7-ardb+git@google.com>
Content-Language: en-US
From: Tom Lendacky <thomas.lendacky@amd.com>
Autocrypt: addr=thomas.lendacky@amd.com; keydata=
 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
 vFkWitqCJg==
In-Reply-To: <20250909080631.2867579-7-ardb+git@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DS2PEPF0000455D.namprd21.prod.outlook.com
 (2603:10b6:f:fc00::515) To DM4PR12MB5070.namprd12.prod.outlook.com
 (2603:10b6:5:389::22)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5070:EE_|CY8PR12MB8066:EE_
X-MS-Office365-Filtering-Correlation-Id: e1f39264-72fa-472e-9e10-08ddf17a02be
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?d0xjUlNUdGgvWTg5cWpvMWovbExpdFdmaE9zSlRWRmNRdUIwNU00bG8zZS9X?=
 =?utf-8?B?SVBtZVBYd0Z6a3hTUXo1Q3lPSjN1U1dHalNySitVckV6aEhyUGpCQUdYcU1L?=
 =?utf-8?B?Ky81bVNTR0kzVzlGQlFYampTbWlWOVY5amNHa3Z0Yk4yclhDeEMwVEdqWGo2?=
 =?utf-8?B?WWI5UWliQytYT2RlUDdpWFZRcnVteHR1bUkrdlRlWGFIWHY3dG12TW5PVDln?=
 =?utf-8?B?OHU1MFErZnVjNWVBOGFiUmk3VWRVaXBVR2tGMFExRm1uMnV6L2RkR1p0NVox?=
 =?utf-8?B?TUYvWk0zVW83L1BSVk9aaXFFOFkvRGptWnVaL2ppek1qNElVTXNrMXJZOXov?=
 =?utf-8?B?czNBZmgxR3RlYUllNU1lMEdFdlJPV1RYeGZ3RlpmT2tvM3hOT2duZTUyL2sy?=
 =?utf-8?B?bHY4ZlF4Z2JJdy9MdFRUa3pnTDNjUEczWGdWNGU3cG44SE1ZWlBPSTNYeGtK?=
 =?utf-8?B?My9aOFZ2TEs5bjI1Tk5QbkJFc092ajlkc2NQVm1QQ0FEbEsyeUNDNS9wR2J2?=
 =?utf-8?B?bHF3OCtEK0lyblNtWjR4emo3OFJKdS9GeW94bjhUcmhXZzNKYVRlSGFDMTBI?=
 =?utf-8?B?ZTlmNUxnSXpBRkpFdm1rWGt5dk0wRnRqUkZVeVd5eG9vOW4vTEtRMW1qRnlD?=
 =?utf-8?B?VC8xK1JjSVRkSjFxY0szVkhZRk9nQm1hTzdpcVRiOTE5OEtudGlhZFpXd2sw?=
 =?utf-8?B?cmtGeTdJRG55UGRKY1ZOdGN5SXRpUGRYU05PYVc4anBaTGs5cUdQU1c3VXVF?=
 =?utf-8?B?N2R3SElmd0R4Ly9ONTIxSUJDbEorWGExcGdSckFHdXJDTzE0VDBISnpuMmJG?=
 =?utf-8?B?N2NLRFJPU0kzdFp0V3haWTJqWGJpL1k4TnllYXN4bG5mZTZNMElrTjlmSmdz?=
 =?utf-8?B?ZHpxb0lGUDNYOWg1TFlGRStCaU1xaUJYamlsMmVtcnJiNTFXNHZIS2tHanZp?=
 =?utf-8?B?T3ZkNWw2SDN5YkxjdEhwV3VrOGlXOGNVTnJvRW01Q2V4NUVsNWJzZFhXckdU?=
 =?utf-8?B?aHlFZ1dKalVOdDh4WFh1THZObWl4ekFXY3Avci9jMTJtbUd6cEs4ZFpOOG5S?=
 =?utf-8?B?YURtcnBGaUpUak9zWDBsTXA4dFFtY3ppd0ZJakxhNU5wQjM2Wjh5VjJjWnQ1?=
 =?utf-8?B?QjJJdnk4OXhua2Z3Y2U5cWxNQ3BzRTlhckFIbEFrL2R6MW1XSWFWYVhVdzhr?=
 =?utf-8?B?SWt0VFU2WHE1WU9uYjdTZWVMOTAwby90VFFEOS95NjlaWG1wVExKN3dYQ0sr?=
 =?utf-8?B?a3RXN0VoVDlyY1VmYVVReGFRVzA3UjF6RVlqMXZBbmNFN1BLYUswUy9YZ2Fr?=
 =?utf-8?B?Q1ljMXdzVFRpL1RjVmdwK0xXYzZLNlBOWjgwbDljUkhTTmVtOXZhdkpPajNW?=
 =?utf-8?B?UnY3SXFZWEJoWHc5V3B0Q3prZlBsaGUxYU9RaDBFZUR3Z1F4dG8vdmRiSm9U?=
 =?utf-8?B?TXdmWVVHekZHc2lKMlMxOVVsSlF6WVdoWStRSkhVeTRCTmpUWU10Q2w3VS9F?=
 =?utf-8?B?RWhaeVRzZi9iYWFTY2VHenJRWlRNSGlJYXJGQS90V0svREFLb3ZBaVZQREhu?=
 =?utf-8?B?ekg2MW1FRUo3UmpMR2JFTFdnMzJpdHlRSjA3ZlZ3d1g0OWREZkM2QlZZMFFQ?=
 =?utf-8?B?YXZRRHcxYVI0d2xUbFJVdnB6bk9xenA2V0FWakxCSG1sV3ViRTV3MEh1RU9r?=
 =?utf-8?B?Ni9HbmNGbG5NSW54Y3BQVzRuMHFUOUE4cjg5cHlLbTEzLzhrb09udko3Z0JV?=
 =?utf-8?B?VkY3c001UDdrK2Z0WEZCOStyV3Zxb2RIbzhhdFZ5NUllYk5JeDJjM2NnK052?=
 =?utf-8?B?Q2lGL2RRU2NCTVV6b3c2M1ZCTWpDT2NTUDNJN1VsWHQxU1VuNlFzMy9DOElC?=
 =?utf-8?B?TmRIUTZaQ0M0ejZJaDNHSUUvZ3c5MkRlUTlaaWtlNHhQS3kvSG4rWE85K2My?=
 =?utf-8?Q?5BFkEQg7b1k=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5070.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TGlEVnA1SU9HMFpnbHJDUktmdjl1QkgyUllZcDVBbk9QOEo0MEhHYzdTajIy?=
 =?utf-8?B?amIyMm4vYVRXNEF2dyt2SExoLzFOWUcwTitCeHdNTGd6b2Y5M01vMU84bDRD?=
 =?utf-8?B?TGRSZTZrZzFPcWpQK1pVbldtNElSaHE1ZGY3VytJdlZna3Y4OURsOC9sQjI4?=
 =?utf-8?B?MnpLanJDS2xrU3Q2Y21YRTgwNHJmcFFNWW9aREM5aGZKOEhPaVFEWjlOQ1lV?=
 =?utf-8?B?bVBSV0hwVzNnNFY3R0dtL09xbk9FTTJ2TUkzd2xYN0hRblBQaElMUFNRYkpL?=
 =?utf-8?B?Tm05YWVtdml6Sm9TZkY5S0NucEpRd1E3WG5zUktxREozVUQ3OWV1ZXA5Wng1?=
 =?utf-8?B?MWc1VE8yV3RLQnJTUGpNSkl6bFg2Q0czZlR3UVdUYTRUVkVqbHlSRlRsdTdt?=
 =?utf-8?B?WVNIakxUbHZMVHBsYU5tT24xcm04bWc2MWhUNWZ3bUkxdk1WTW9PRC9Zc1lB?=
 =?utf-8?B?OUVxa1gveHYxR2tFWmdYNWpFdVBYTjZWTVk3dEZHNXFWOGZmTHpNL1Q3eDN6?=
 =?utf-8?B?Q2pYVjRTTlZXdEhWSEJXNXRyQVVkN2tFcVJuYjRjK0xCNm9HUGRVbHNEYkdt?=
 =?utf-8?B?bStEbFMzT2lQaE03UUVNRjFlc0tGUEw1YXpZS2FKaEJpMmR4Y3hKR3NxVkEz?=
 =?utf-8?B?ZG1IZjlQU3JDWExpbGluU3cwZGpxb2VGVFh6RTN5ZHRhZWV6QjE4ZUdpbCsv?=
 =?utf-8?B?ai9BaklQS0VqaHcyTXJ5TzVmUHB1T3JlYjR2THBBTnluaHZvaEgxb05ET1Av?=
 =?utf-8?B?dWxQcDFtN0VrbHhJRTZNUk1UdEpxTFFwazltRUZzL2FFZk4wekZnekMxeXV3?=
 =?utf-8?B?YUdNdkpBSTRxT082aHNLNzRPOTlYRGpxQSswcGZ2dFpuWU5NQmNiNWhXcllp?=
 =?utf-8?B?a1d2WTZwdFVhelNremZRcEFrblp3ZHpqZXRmeVR3UnFaRVQveEorTythTlQr?=
 =?utf-8?B?YWhJL1ZpM2lPVHgrbndaSk9OUW9UaXdtcEJXK3dheVFqdTVZQm0xZjFUOUhW?=
 =?utf-8?B?SitmZlpmVVBzZmpaNmFUOU5UNld5Z0ZGQ0xDVzZJaDFVL1BjUUpxYlUzTHFk?=
 =?utf-8?B?MWxJdGVVRWpsaEdNYTYyLzJRNUhEMHZIaFFVVmlaSlliSmVtdVJuRmJmdlpL?=
 =?utf-8?B?aXJWa3I3dnptdis3ZHdnaU5WV2hWMHkzMWkxTUxEaTMxQm9EK29lMEgyKzZj?=
 =?utf-8?B?NkxQS1IvWnM5N01FcG1FSU85M3pSNWRHaUlHQ3NRMEMzK2hZcDhPaUVkbmtH?=
 =?utf-8?B?WG5HdnUwL295TmJwKzJwNi9USWEwV0JyclloelBZcXMvbTN1c3crQmdKOXpH?=
 =?utf-8?B?a3Mxb2JyWDd6NDhWWXEwM1lhQk1HWUpjM05Gc2psWk9CbjUrVmt6cVFpZ1Qw?=
 =?utf-8?B?WWd4cTkvOHl0ZDM0dzVmbDBnODE4dm5odnUvTy9FeCs1cHJ5ZWxLVFFSSWM5?=
 =?utf-8?B?Q0wreC9HR24yZU02SmNvRUR2SmUxNHdNUnl1TERyYjZ3empqeEZjbjZPUVl1?=
 =?utf-8?B?UEl0WGpnQVJqSWtKZ1dKRnlxZFFrWXpmVXptemRiMVNMMUFabjdXcG1Pclox?=
 =?utf-8?B?Vlk3YVVJQW42ZUxZa053aUlSUjdKd1UzLytabThJaTNRdkJreDRxdE50SHlw?=
 =?utf-8?B?U3FBdURNL3ZXdmtBaUxubldEcjBtTVJjeXc2Y1BNbnpmSmtKOFRlRHJ0Tkg2?=
 =?utf-8?B?QUMxZFNOTUJmV2FadlF0RS9iZWNNUTBYTkVFSjU5N0IxNWozbjJFbm5vYVRP?=
 =?utf-8?B?VWN3TkNaMGVuaUJnZG5aNEVtNXRaODQ5TWRMODErQXovWitvVkRXakhyTUlo?=
 =?utf-8?B?dkdXejFDNjZKTEwrR3BhVG53R243aEhsM3d0TlhQdlAzTjRvOFFhckgwdnVa?=
 =?utf-8?B?WnFJQnFHN1RzeVprVHJ1NVF3MW1NT3cvcVZhMldZWktGL1hLYlk1OU5HU3lK?=
 =?utf-8?B?b1VjTEtDNDdYQm81UnhrUjZUSVhIZnRTMzlacHVFdThDMkxndVRtUHJaQzJH?=
 =?utf-8?B?d3Q3TUFkSSthaDN6NDZRa1BUaFVmelQ0V1VrRVlEMG80aHZlM3EyYkR5VWVl?=
 =?utf-8?B?WG9QbmR4MWNYbTEycW96U29tRmYxb0RLSW50VVlUdE9CeldleFpTZmNWSElI?=
 =?utf-8?Q?padXOSsNau/SAci8hJWey7eFg?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e1f39264-72fa-472e-9e10-08ddf17a02be
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5070.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2025 21:27:29.2214
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EVIVQF595jjMaoNTijQObl4A1uJSwHjZSl+En5RFcysoym/SaGHkiC2wXem7hMK4+U0MeuRfYthdr45xg8vhNQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8066

On 9/9/25 03:06, Ard Biesheuvel wrote:
> From: Ard Biesheuvel <ardb@kernel.org>
> 
> The x86 EFI stub no longer boots the core kernel via the traditional
> decompressor but jumps straight to it, avoiding all the page fault
> handling and other complexity that is entirely unnecessary when booting
> via EFI, which guarantees that all system memory is mapped 1:1.
> 
> The SEV startup code in the core kernel expects the address of the CC
> blob configuration table in boot_params, so store it there when booting
> from EFI with SEV-SNP enabled. This removes the need to call
> sev_enable() from the EFI stub.
> 
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> ---
>  drivers/firmware/efi/libstub/x86-stub.c | 21 +++++++++++++++-----
>  1 file changed, 16 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/firmware/efi/libstub/x86-stub.c b/drivers/firmware/efi/libstub/x86-stub.c
> index 0d05eac7c72b..c4ef645762ec 100644
> --- a/drivers/firmware/efi/libstub/x86-stub.c
> +++ b/drivers/firmware/efi/libstub/x86-stub.c
> @@ -681,17 +681,28 @@ static efi_status_t exit_boot(struct boot_params *boot_params, void *handle)
>  	return EFI_SUCCESS;
>  }
>  
> -static bool have_unsupported_snp_features(void)
> +static bool check_snp_features(struct boot_params *bp)
>  {
> +	u64 status = sev_get_status();
>  	u64 unsupported;
>  
> -	unsupported = snp_get_unsupported_features(sev_get_status());
> +	unsupported = snp_get_unsupported_features(status);
>  	if (unsupported) {
>  		efi_err("Unsupported SEV-SNP features detected: 0x%llx\n",
>  			unsupported);
> -		return true;
> +		return false;
>  	}
> -	return false;
> +
> +	if (status & MSR_AMD64_SEV_SNP_ENABLED) {
> +		void *tbl = get_efi_config_table(EFI_CC_BLOB_GUID);
> +
> +		if (!tbl) {
> +			efi_err("SEV-SNP is enabled but CC blob not found\n");
> +			return false;
> +		}
> +		bp->cc_blob_address = (u32)(unsigned long)tbl;

I think we ran into bugs where the cc_blob_address was random data from a
boot loader when SNP wasn't active and that's why we always initialize it
to 0:

4b1c74240757 ("x86/boot: Don't propagate uninitialized boot_params->cc_blob_address")

So we probably need the same statement that is at the beginning of the
decompressor sev_enable() at the very beginning of this function to ensure
cc_blob_address is set to zero:

	/*    
	 * bp->cc_blob_address should only be set by boot/compressed kernel.
	 * Initialize it to 0 to ensure that uninitialized values from
	 * buggy bootloaders aren't propagated.
	 */
	if (bp)
		bp->cc_blob_address = 0;

Thanks,
Tom

> +	}
> +	return true;
>  }
>  
>  static void efi_get_seed(void *seed, int size)
> @@ -831,7 +842,7 @@ void __noreturn efi_stub_entry(efi_handle_t handle,
>  
>  	hdr = &boot_params->hdr;
>  
> -	if (have_unsupported_snp_features())
> +	if (!check_snp_features(boot_params))
>  		efi_exit(handle, EFI_UNSUPPORTED);
>  
>  	if (IS_ENABLED(CONFIG_EFI_DXE_MEM_ATTRIBUTES)) {


