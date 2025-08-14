Return-Path: <linux-efi+bounces-4554-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 82686B26D17
	for <lists+linux-efi@lfdr.de>; Thu, 14 Aug 2025 18:56:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C04EA26B06
	for <lists+linux-efi@lfdr.de>; Thu, 14 Aug 2025 16:53:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2520E220F5C;
	Thu, 14 Aug 2025 16:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="J6pwmJ8O"
X-Original-To: linux-efi@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2136.outbound.protection.outlook.com [40.107.94.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFFEB189F3F;
	Thu, 14 Aug 2025 16:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.136
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755190391; cv=fail; b=Sjrp+Vcv3/TFHFBmY77PAO0DoUr81icL26jODXTli5PUQCbroeymF4epya6wkOv0TBv9kub8FFJ5UdGX/JYFJRypFr7AYINxl9X8aVrcLeX4J73AuUADu0V5i0qfdExpVXZpkvQpPxUSmkUgtRW3qGN7tnpIIv2T4XJa7BapeiQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755190391; c=relaxed/simple;
	bh=sc3gfZ4nGvKFVsMqS9gB29CNtupExAllNxPjSCI6Kno=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=NhEDKSSqAeyXf5BK0ULVNvVPYNILtOkULSDxrGlF57BRF5lgPCD1JCNcdXynI5nYR42cObZb/l8yTQEXoFIEkXb01gIAYCYnzJvTvwagnyIb/xYqBU4hxFiU13+hf2vndXsdEbNBo7uetgScj7eVdtYvpt6NJPv/+QahTM4vdX0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=J6pwmJ8O; arc=fail smtp.client-ip=40.107.94.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E8MJjxICWUB8ebBOVq6RoHgA3v3hwpc655637132oZ+Cs94vuL4JT1Sj2gxUXIqrgAbsGmfOASE2Vo/lNYEygt+P5TV5XV7DZXyB3F80RY3HWxUdQrJzOo8SlapFo9+t7VAArB2INxdGB0JN1zBz1LRsftg3M5QtXfurPXCydBqi5FjTrrn+e/2Hqey3md6qRh5BQtymvya1kxp7/Q0/L9yFyZw7hA8btQGENUTqCvcgyKCL8Voi5k383g4hcv4z3V+xFY2tCQwlxznFlabG/Id2hk6/rR2ArInlW0WI60ivmkj2G9T6+00/JdbOrHJo9fcZcVbHLxrVZLbyA3B9XA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YzwmSN7axjrbTpyKQElaA0AcHIs92Rj7KpGwamN7seM=;
 b=E7FpdhHknwLVDFz0Il6W1aPGWsa6jg6nTkIt6iG8XpVYwCIyWRFH0cMHMOVYESSKvtrzIX8tDktcj/15f16ZxniJqcBWGnUhyMlun6mVJcjHnATjNAdYZwjl4OTjqzB7IGf61avZ3gnxhf/EUOfH02VfN0vFOfCL/b5sl6AJiKyhVPC+SHTD7TBmuI/Zk+o1U70ZOTtPwlqmtHljm8YWkTvFqQIq8hUa5s59Z3K2qUklZ4P7tbVbDtI0CNefWVdzqZ4Seqtr0gUKvoLKbIpLcC7g3NPZLmGoQ/k7Wp773LjFf4L/PRwqeSO4FfbtZXVUF0q4JnusS+xqdRvDibdf6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YzwmSN7axjrbTpyKQElaA0AcHIs92Rj7KpGwamN7seM=;
 b=J6pwmJ8OpuOQSqRIEJWQN51T0XPdwMLQONss0dHgcTbXFcgIRxwc+sGZQSEXLMx99XkbH3EvjwrcnvBYHY72tqzLGcX9o5F5X+trEPZQBhvdOXMMxURrMthlGUnfm294GHoZFH3sqtu7bqi+BdG1i+BkY9koN3R5PtiDjbIX+IA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from SA3PR01MB8473.prod.exchangelabs.com (2603:10b6:806:397::12) by
 BL3PR01MB6881.prod.exchangelabs.com (2603:10b6:208:354::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9031.18; Thu, 14 Aug 2025 16:53:03 +0000
Received: from SA3PR01MB8473.prod.exchangelabs.com
 ([fe80::46d7:1d3a:dc9c:69c3]) by SA3PR01MB8473.prod.exchangelabs.com
 ([fe80::46d7:1d3a:dc9c:69c3%6]) with mapi id 15.20.9031.014; Thu, 14 Aug 2025
 16:53:03 +0000
From: Daniel Ferguson <danielf@os.amperecomputing.com>
Date: Thu, 14 Aug 2025 09:52:52 -0700
Subject: [PATCH v6 1/5] RAS: Report all ARM processor CPER information to
 userspace
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250814-mauro_v3-v6-16-rev2-v6-1-e5538d534aa0@os.amperecomputing.com>
References: <20250814-mauro_v3-v6-16-rev2-v6-0-e5538d534aa0@os.amperecomputing.com>
In-Reply-To: <20250814-mauro_v3-v6-16-rev2-v6-0-e5538d534aa0@os.amperecomputing.com>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
 James Morse <james.morse@arm.com>, Tony Luck <tony.luck@intel.com>, 
 Borislav Petkov <bp@alien8.de>, linux-doc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, 
 linux-efi@vger.kernel.org, linux-edac@vger.kernel.org, 
 Jason Tian <jason@os.amperecomputing.com>, 
 Shengwei Luo <luoshengwei@huawei.com>, 
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, 
 Daniel Ferguson <danielf@os.amperecomputing.com>, 
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 Shiju Jose <shiju.jose@huawei.com>
X-Mailer: b4 0.14.2
X-ClientProxiedBy: CH2PR12CA0024.namprd12.prod.outlook.com
 (2603:10b6:610:57::34) To SA3PR01MB8473.prod.exchangelabs.com
 (2603:10b6:806:397::12)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR01MB8473:EE_|BL3PR01MB6881:EE_
X-MS-Office365-Filtering-Correlation-Id: 4c6db9c7-0d92-4b0d-33f9-08dddb5308c9
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|7416014|376014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UHFEdC9LQ3hRdWdkYThxRUpOVnJyMUFUbzZqcGhSZEttZ0U1TjA3b0U5YXBK?=
 =?utf-8?B?YnRjT0lmM2VwVmY4cnFaTTd2c05HNXN4NGR4dE15eUIxVXp5ZFY1QmV3ZGU5?=
 =?utf-8?B?SE1XWWFLZVlzOGhOZWE2a1ZHdTJOMk9lMngvaHZFeFJ5aEFmSG5wdUhwNi93?=
 =?utf-8?B?M21abk4vSStSdjZHSTFqOS9EcHAzWWNuVWlNRVl2N3VncHp3MVlMT1pQMlM4?=
 =?utf-8?B?MlVwOElmeEpDWUtMY3JwR290emlTVFVQdU1hcGx5L1ZYa0g4N3hwMlVTT1hs?=
 =?utf-8?B?NmJGQ0pac1ZvZk9LNGlvc2JBR29GYjVxdHRPUTNGQzNSUmVsRGU4dFJaM05H?=
 =?utf-8?B?MHNpUW53czYzZXZOVlJpR2wwVmVtTkVydzhiZ0ROOEFhbkJVakVNc3BYcGNC?=
 =?utf-8?B?NTI0WWc5Um9uVkVIQ3R0QXpLTjVUK3B1SDhsQm83Z0Rsb0o2RlV4dDJTZE5v?=
 =?utf-8?B?ZjVpb2FpUHcwMHl4UVdoME92aUlOODRFTDc2QTlGRzZoNnIzUTMySkh6Z2Rl?=
 =?utf-8?B?bFBNY1MwaUVMdVhEalRzdlNXRzFDNHJ2YkxLbGxmTmt4U2gxS3NqUDhzTFMr?=
 =?utf-8?B?R29sZHVEU0tuTExiZW52ME5rbzdLR1BsbE9PQkUzNG9nVFRWRGFER1RBZUpJ?=
 =?utf-8?B?b0Nqc255cW1RZm1OLzRiYi9uRUdEYWw5bUk0Ti9aS2xGL2lQZkJtVmVBd1N6?=
 =?utf-8?B?d1M3bFhnaVZCZkRYZGtaWVlIcEZHTnVrZzR0Tk1BTWNXRklZVURPZ1VORFFP?=
 =?utf-8?B?alBzSFhSYjFjYTlUSmJqV3A4cVM5OUpEc3ZXT0U0bVgxQkpGazd1SWdySjhi?=
 =?utf-8?B?akl0SDUrZnJKaHJBNDZlU1BHajBqdFB3RTQzdXMxQkdib2pEUzlXTThmT0VW?=
 =?utf-8?B?RDg1ZmhHWG1iUzgvRlIvVUtHMEs0SlQ5QXB4MTZiR3RCR084TnhQb05UdTRD?=
 =?utf-8?B?YXVVODFKcDVPRW5SV2Y5R0k4V09BeXhRYkxkQVlacHovYTlBMmVYeE81L1d6?=
 =?utf-8?B?NTRCeFBnZCtCNnNwZHNqK3NGVzVOQ2hIY05SRmxreVRPeHpRZ0o0UXV5Qktj?=
 =?utf-8?B?TWFCU1BDWWp2ODRVM0xSdGcxdFVzZzRLWDNRU3BIemFxcTdVVWlDY3lSNXZa?=
 =?utf-8?B?TFd2Q2FjeFdwUmVEYW1obURNa2ZNaHh4U1JsT2dRNGc3QUppck11NDE1VjR4?=
 =?utf-8?B?Wmh5QXl3aTNNOHhLM2JzVDBiMFNCNmxUd3VDeTNDRFZ6ekRpWitFK05hMVRo?=
 =?utf-8?B?MHBPVzFwUzNjRmlEejBZREYraHBwMUFVak5RNlRyWWh0Zi8zTldTQWVDV0J5?=
 =?utf-8?B?TUN3T3Q2blp3U0F3eUZnMS9DMHB0elgwRGVINDlwbDk4N1FIL3VZNTladDln?=
 =?utf-8?B?dkIzc3A2cGZSNXFxeW41ZFFvODBucEw2dllPZFNXajJqQTUwdnJrbUxid3lQ?=
 =?utf-8?B?MEVjOEdOUjBycnczYVFjTDVjUytwTGlTVWFpeVBiUFBjeTBYUC9vT2xaVXl4?=
 =?utf-8?B?bjVYemZSVVZ2MmI2czc4dHluNlBxZ1c0RW1JNnZuczdXMEVNZkIvb0JKWkhi?=
 =?utf-8?B?L0tEaDMwK1RBSzNpc2JYK013aDdTVVN3aXpjQ2k2Z0VLalZGVElLbStQNmEy?=
 =?utf-8?B?Z2xMTCsvalNVZENETkJYU3BReW9tQ1R6QzhITCttR3EyL0pFSEU0YUtqeU05?=
 =?utf-8?B?c3I5aENYQ3M1bnB0Nk5yc1RiUFRyUlphV09sTEE2cDJteDdUUHpIVVBRb0dt?=
 =?utf-8?B?ZURJNk8rV3RzVk1CWExmamY4aFRjZVdDSkI3cHlLS2pHY0hVOGx1aHppSmt0?=
 =?utf-8?B?SGpya1d0dHdCdzJRQ3FEWGN3WXlRZkx4SUZZTmIwTEZ3NmxzZEdaWHpucXBX?=
 =?utf-8?B?YTQwMmxUcGxCZ3FxTG9nWVhndDA1SnlqVXAxT1ZEaVZ2a2J0dUVTTlZXV081?=
 =?utf-8?Q?iZnkEJ1Qqfc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR01MB8473.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(7416014)(376014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZENrNEJBTWZHNEZRN2YxdUlQeHpsaUNqRnQ1NTVQelpVdnVVNHYvOFhQcVRY?=
 =?utf-8?B?cksrRnYzaEJwY1dJcVdxZTNocVpndnhkMUZzcVJtNzFFSGpsdGpTTkd3WXVS?=
 =?utf-8?B?RmJEMEVPS0RGSTF3TWUxQ2wrNTMwYTdEMkpQODJON1BMeXR3eldDZmZzdWs1?=
 =?utf-8?B?T002OW9QbTlPWGJRRUF3Zk1qUnN1Z1hqcDROTEdWU3pmbk1GM1ZBcENjMFdU?=
 =?utf-8?B?VndoZHY0N0F2bHp4YURLbHpTNktNVDA4MkxuaXZnYmVWbVg0NHVhYW9mRnli?=
 =?utf-8?B?dFVMWkdMclFXZmxwT090KzQxdXRDbktPbzJMTXVEdWI5cFZ2NGRlellkOHhp?=
 =?utf-8?B?SVlORnFiVWVwMGV1TUNRd2FTY1pjakgrdlFUaWNOQUpPQWFXN0pzNXY4eWZn?=
 =?utf-8?B?M3Zic1hqS3dpczNhS0NxUXpic3ZpVkNta2JsU0FTd0c2S1VNaTgwbjNHSXR2?=
 =?utf-8?B?dTNzZTFlOHBxeE5uNkZSSHo0dHZFQzNkcmgwVE95cTZ2djR3YzI2Mi9WRUxC?=
 =?utf-8?B?ZThMS08wRkdNRkZnSTQvcFpIMmVLNVVja0N6UExvT25HOGIyTGVJK1IwU0F0?=
 =?utf-8?B?UHlxRlVnYnF1ZnNLVG04YzRyeXZjczhjamZqb3Q3NG1Za2hleWMwYllkWVFq?=
 =?utf-8?B?VVhhZktBWmRmem82N2ZKUk0xTEo2T0VHYWxTd2ZKbThTS0dVYmExOTBDYmpw?=
 =?utf-8?B?Z3A1akh6Y0Q0QU94ZUNaOEMyVlNySG5Fb3RZVjlkR1NHbTg5MFZLVXJ6OHVD?=
 =?utf-8?B?MVZieU9yb2pLWXgyWHkvN05vYzJFQ1hhZ05Xbm1ST2c3UlIxYVI0b0RnWkZx?=
 =?utf-8?B?R2tCVVMzUS9TUGJFeUdEZWtpRXJENUxVS0kvNS90YmV2LzdPMEgxeXZMTFlS?=
 =?utf-8?B?SjZ4cU0xQytMN016bUtVZUtEVzFSRGNkWXF6cVl4b0JQR2lxRCtnYllFa2JB?=
 =?utf-8?B?MzdMM0YrZEJDaG5pSmp6ZTZRMnpjY3ZEelpxMW1TMTdEWnUrQ1ZkRUg0UVRK?=
 =?utf-8?B?ZjYwekpWR0V0eXEvRmIwQXpkakhqRjVwclRpZjROQnNjd25vdnRETnl0TWdy?=
 =?utf-8?B?RnBDWk5oTzNoVWdvdGtId2Njd1NSRi9HVlF6L1JMMldERU9MNkM2dEtUYng3?=
 =?utf-8?B?enh4cFp2bnhHMXNVT1g4ZVQ1VEROTTdNZmtHSnVZTXozRG5qemYrVVYxUFRw?=
 =?utf-8?B?bkFZNWEyLzNSTTNEOVBVanpHbjZaRjl6SUZGKzY5R1RrMTJGeXoxWDdUWGhw?=
 =?utf-8?B?UGJCR2g3a053VEs2OTRKeFJYUXpJcXhyUElrY2RXbk4rYTZDM3FhYmtRYkQz?=
 =?utf-8?B?aytSaDF6RFRoNEhsa2Y1dTg2RTB5S2VXRGdab0M1RnhjQkozWDIzbm8vdFJv?=
 =?utf-8?B?NCtoQ050WUhYaHBNbmhHaUxFa1orbGU1RFgzV0QxZFAyN1FhSFEydHZUV0cz?=
 =?utf-8?B?MjJaMU8ydTAwaWxUZjB0N0F3dzNKeldZTVRyTjk0U09qbFpyOEhidzFJWUw5?=
 =?utf-8?B?MnRzVmNhTm84MlBzdkpCWGVrbkI0ZWhsYWp1ZHlyS2xmK0F1NXNxdDNLL0JX?=
 =?utf-8?B?MmNoRjlpdFNDNThzNnFVVVhWa3dpYStzSzFsaitmZzkwcjBOeWpEaEtJT21M?=
 =?utf-8?B?ODdIQTkvSHBCdWtXWHVISEl2VkozUFJvNW1jME5iUjB6SVpLcWtTdGEwbU1R?=
 =?utf-8?B?YUkwRzdZZnhyVDN3YWZRc3RkVlliRHFVWXBTdnNOdlJRaWsxelZMUmVlQUsv?=
 =?utf-8?B?M2w5WllINGNBZ3lIcGt4ZTNJNmE5MkhmWWI2QmlLWFUyVE5xV3BSMVcrTm9z?=
 =?utf-8?B?ek1UZ2lDdjRYY2c3dFJ6dVc4U3RzWGxiRUtROFBiYXFHZEsycHRFN01RVCtT?=
 =?utf-8?B?N0dtWWFWQ1lNeHhyUU4wTlBJN2FxOU82bzRuVEpzY005YlFvb3ZPL1pjZTAr?=
 =?utf-8?B?Z3hwc250NjZhM0ZCSHMwdUhjcXYxNnZzbkdPTHhvVjNXZVFnOFF0UkR5WGwv?=
 =?utf-8?B?RlhVbmpPK1RRMnFlelV0bU5KWXpWSTVVOWVGckRFdk10YnorU3lNY1I0UWhw?=
 =?utf-8?B?V2cwZDdpZk1PaUNFS0FFTHo0cUFKNFR2UHJSK1UvVFo3dnVsQ01ZM09uTzZZ?=
 =?utf-8?B?TE5pSUVMa1Vra1N6QStOOU5IaG5VdWZCem1tMU91TEtySExnNkpGN3Y0czZw?=
 =?utf-8?Q?Ix8SjvhGaeaAceRWvshOAKY=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c6db9c7-0d92-4b0d-33f9-08dddb5308c9
X-MS-Exchange-CrossTenant-AuthSource: SA3PR01MB8473.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2025 16:53:03.4596
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X2kTw+FN005VOl0oklBaVEM1WnT5puvxfh3CUm9WhlPXqT09x4tmRrSzUR5rRgX5tE+U4TV9zMNd4yfArAES4R1NoiYlGd00HyrBkNR/vwvwwjXjeY3Ng1piwcZPI9Pj
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR01MB6881

From: Jason Tian <jason@os.amperecomputing.com>

The ARM processor CPER record was added in UEFI v2.6 and remained
unchanged up to v2.10.

Yet, the original arm_event trace code added by

  e9279e83ad1f ("trace, ras: add ARM processor error trace event")

is incomplete, as it only traces some fields of UAPI 2.6 table N.16, not
exporting any information from tables N.17 to N.29 of the record.

This is not enough for the user to be able to figure out what has
exactly happened or to take appropriate action.

According to the UEFI v2.9 specification chapter N2.4.4, the ARM
processor error section includes:

- several (ERR_INFO_NUM) ARM processor error information structures
  (Tables N.17 to N.20);
- several (CONTEXT_INFO_NUM) ARM processor context information
  structures (Tables N.21 to N.29);
- several vendor specific error information structures. The
  size is given by Section Length minus the size of the other
  fields.

In addition, it also exports two fields that are parsed by the GHES
driver when firmware reports it, e.g.:

- error severity
- CPU logical index

Report all of these information to userspace via a the ARM tracepoint so
that userspace can properly record the error and take decisions related
to CPU core isolation according to error severity and other info.

The updated ARM trace event now contains the following fields:

======================================  =============================
UEFI field on table N.16                ARM Processor trace fields
======================================  =============================
Validation                              handled when filling data for
                                        affinity MPIDR and running
                                        state.
ERR_INFO_NUM                            pei_len
CONTEXT_INFO_NUM                        ctx_len
Section Length                          indirectly reported by
                                        pei_len, ctx_len and oem_len
Error affinity level                    affinity
MPIDR_EL1                               mpidr
MIDR_EL1                                midr
Running State                           running_state
PSCI State                              psci_state
Processor Error Information Structure   pei_err - count at pei_len
Processor Context                       ctx_err- count at ctx_len
Vendor Specific Error Info              oem - count at oem_len
======================================  =============================

It should be noted that decoding of tables N.17 to N.29, if needed, will
be handled in userspace. That gives more flexibility, as there won't be
any need to flood the kernel with micro-architecture specific error
decoding.

Also, decoding the other fields require a complex logic, and should be
done for each of the several values inside the record field.  So, let
userspace daemons like rasdaemon decode them, parsing such tables and
having vendor-specific micro-architecture-specific decoders.

 [mchehab: modified description, solved merge conflicts and fixed coding style]

Signed-off-by: Jason Tian <jason@os.amperecomputing.com>
Co-developed-by: Shengwei Luo <luoshengwei@huawei.com>
Signed-off-by: Shengwei Luo <luoshengwei@huawei.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Signed-off-by: Daniel Ferguson <danielf@os.amperecomputing.com> # rebased
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Tested-by: Shiju Jose <shiju.jose@huawei.com>
Acked-by: Borislav Petkov (AMD) <bp@alien8.de>
Fixes: e9279e83ad1f ("trace, ras: add ARM processor error trace event")
Link: https://uefi.org/specs/UEFI/2.10/Apx_N_Common_Platform_Error_Record.html#arm-processor-error-section
---
 drivers/acpi/apei/ghes.c | 11 ++++-------
 drivers/ras/ras.c        | 40 +++++++++++++++++++++++++++++++++++++--
 include/linux/ras.h      | 16 +++++++++++++---
 include/ras/ras_event.h  | 49 +++++++++++++++++++++++++++++++++++++++++++-----
 4 files changed, 99 insertions(+), 17 deletions(-)

diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
index f0584ccad451915a2679c17f2367461c141663c5..99e25553fc1320b2306efb751e12f2377c86878a 100644
--- a/drivers/acpi/apei/ghes.c
+++ b/drivers/acpi/apei/ghes.c
@@ -527,7 +527,7 @@ static bool ghes_handle_memory_failure(struct acpi_hest_generic_data *gdata,
 }
 
 static bool ghes_handle_arm_hw_error(struct acpi_hest_generic_data *gdata,
-				       int sev, bool sync)
+				     int sev, bool sync)
 {
 	struct cper_sec_proc_arm *err = acpi_hest_get_payload(gdata);
 	int flags = sync ? MF_ACTION_REQUIRED : 0;
@@ -535,9 +535,8 @@ static bool ghes_handle_arm_hw_error(struct acpi_hest_generic_data *gdata,
 	int sec_sev, i;
 	char *p;
 
-	log_arm_hw_error(err);
-
 	sec_sev = ghes_severity(gdata->error_severity);
+	log_arm_hw_error(err, sec_sev);
 	if (sev != GHES_SEV_RECOVERABLE || sec_sev != GHES_SEV_RECOVERABLE)
 		return false;
 
@@ -870,11 +869,9 @@ static bool ghes_do_proc(struct ghes *ghes,
 
 			arch_apei_report_mem_error(sev, mem_err);
 			queued = ghes_handle_memory_failure(gdata, sev, sync);
-		}
-		else if (guid_equal(sec_type, &CPER_SEC_PCIE)) {
+		} else if (guid_equal(sec_type, &CPER_SEC_PCIE)) {
 			ghes_handle_aer(gdata);
-		}
-		else if (guid_equal(sec_type, &CPER_SEC_PROC_ARM)) {
+		} else if (guid_equal(sec_type, &CPER_SEC_PROC_ARM)) {
 			queued = ghes_handle_arm_hw_error(gdata, sev, sync);
 		} else if (guid_equal(sec_type, &CPER_SEC_CXL_PROT_ERR)) {
 			struct cxl_cper_sec_prot_err *prot_err = acpi_hest_get_payload(gdata);
diff --git a/drivers/ras/ras.c b/drivers/ras/ras.c
index a6e4792a1b2e9239f44f29102a7cc058d64b93ef..c1b36a5601c4b12988089ad292ee5f1c5dc862d5 100644
--- a/drivers/ras/ras.c
+++ b/drivers/ras/ras.c
@@ -52,9 +52,45 @@ void log_non_standard_event(const guid_t *sec_type, const guid_t *fru_id,
 	trace_non_standard_event(sec_type, fru_id, fru_text, sev, err, len);
 }
 
-void log_arm_hw_error(struct cper_sec_proc_arm *err)
+void log_arm_hw_error(struct cper_sec_proc_arm *err, const u8 sev)
 {
-	trace_arm_event(err);
+	struct cper_arm_err_info *err_info;
+	struct cper_arm_ctx_info *ctx_info;
+	u8 *ven_err_data;
+	u32 ctx_len = 0;
+	int n, sz, cpu;
+	s32 vsei_len;
+	u32 pei_len;
+	u8 *pei_err, *ctx_err;
+
+	pei_len = sizeof(struct cper_arm_err_info) * err->err_info_num;
+	pei_err = (u8 *)(err + 1);
+
+	err_info = (struct cper_arm_err_info *)(err + 1);
+	ctx_info = (struct cper_arm_ctx_info *)(err_info + err->err_info_num);
+	ctx_err = (u8 *)ctx_info;
+
+	for (n = 0; n < err->context_info_num; n++) {
+		sz = sizeof(struct cper_arm_ctx_info) + ctx_info->size;
+		ctx_info = (struct cper_arm_ctx_info *)((long)ctx_info + sz);
+		ctx_len += sz;
+	}
+
+	vsei_len = err->section_length - (sizeof(struct cper_sec_proc_arm) + pei_len + ctx_len);
+	if (vsei_len < 0) {
+		pr_warn(FW_BUG "section length: %d\n", err->section_length);
+		pr_warn(FW_BUG "section length is too small\n");
+		pr_warn(FW_BUG "firmware-generated error record is incorrect\n");
+		vsei_len = 0;
+	}
+	ven_err_data = (u8 *)ctx_info;
+
+	cpu = GET_LOGICAL_INDEX(err->mpidr);
+	if (cpu < 0)
+		cpu = -1;
+
+	trace_arm_event(err, pei_err, pei_len, ctx_err, ctx_len,
+			ven_err_data, (u32)vsei_len, sev, cpu);
 }
 
 static int __init ras_init(void)
diff --git a/include/linux/ras.h b/include/linux/ras.h
index a64182bc72ad3f2b430c53c7a9e23e798a1c1fbe..468941bfe855f6a1e3471245d98df5ffb362385b 100644
--- a/include/linux/ras.h
+++ b/include/linux/ras.h
@@ -24,8 +24,7 @@ int __init parse_cec_param(char *str);
 void log_non_standard_event(const guid_t *sec_type,
 			    const guid_t *fru_id, const char *fru_text,
 			    const u8 sev, const u8 *err, const u32 len);
-void log_arm_hw_error(struct cper_sec_proc_arm *err);
-
+void log_arm_hw_error(struct cper_sec_proc_arm *err, const u8 sev);
 #else
 static inline void
 log_non_standard_event(const guid_t *sec_type,
@@ -33,7 +32,7 @@ log_non_standard_event(const guid_t *sec_type,
 		       const u8 sev, const u8 *err, const u32 len)
 { return; }
 static inline void
-log_arm_hw_error(struct cper_sec_proc_arm *err) { return; }
+log_arm_hw_error(struct cper_sec_proc_arm *err, const u8 sev) { return; }
 #endif
 
 struct atl_err {
@@ -53,4 +52,15 @@ static inline unsigned long
 amd_convert_umc_mca_addr_to_sys_addr(struct atl_err *err) { return -EINVAL; }
 #endif /* CONFIG_AMD_ATL */
 
+#if defined(CONFIG_ARM) || defined(CONFIG_ARM64)
+#include <asm/smp_plat.h>
+/*
+ * Include ARM-specific SMP header which provides a function mapping mpidr to
+ * CPU logical index.
+ */
+#define GET_LOGICAL_INDEX(mpidr) get_logical_index(mpidr & MPIDR_HWID_BITMASK)
+#else
+#define GET_LOGICAL_INDEX(mpidr) -EINVAL
+#endif /* CONFIG_ARM || CONFIG_ARM64 */
+
 #endif /* __RAS_H__ */
diff --git a/include/ras/ras_event.h b/include/ras/ras_event.h
index 14c9f943d53fb6cbadeef3f4b13e61470f0b5dee..ab217cc277c556b8847971c807ebbb587d5a29ce 100644
--- a/include/ras/ras_event.h
+++ b/include/ras/ras_event.h
@@ -168,11 +168,25 @@ TRACE_EVENT(mc_event,
  * This event is generated when hardware detects an ARM processor error
  * has occurred. UEFI 2.6 spec section N.2.4.4.
  */
+#define APEIL "ARM Processor Err Info data len"
+#define APEID "ARM Processor Err Info raw data"
+#define APECIL "ARM Processor Err Context Info data len"
+#define APECID "ARM Processor Err Context Info raw data"
+#define VSEIL "Vendor Specific Err Info data len"
+#define VSEID "Vendor Specific Err Info raw data"
 TRACE_EVENT(arm_event,
 
-	TP_PROTO(const struct cper_sec_proc_arm *proc),
+	TP_PROTO(const struct cper_sec_proc_arm *proc,
+		 const u8 *pei_err,
+		 const u32 pei_len,
+		 const u8 *ctx_err,
+		 const u32 ctx_len,
+		 const u8 *oem,
+		 const u32 oem_len,
+		 u8 sev,
+		 int cpu),
 
-	TP_ARGS(proc),
+	TP_ARGS(proc, pei_err, pei_len, ctx_err, ctx_len, oem, oem_len, sev, cpu),
 
 	TP_STRUCT__entry(
 		__field(u64, mpidr)
@@ -180,6 +194,14 @@ TRACE_EVENT(arm_event,
 		__field(u32, running_state)
 		__field(u32, psci_state)
 		__field(u8, affinity)
+		__field(u32, pei_len)
+		__dynamic_array(u8, pei_buf, pei_len)
+		__field(u32, ctx_len)
+		__dynamic_array(u8, ctx_buf, ctx_len)
+		__field(u32, oem_len)
+		__dynamic_array(u8, oem_buf, oem_len)
+		__field(u8, sev)
+		__field(int, cpu)
 	),
 
 	TP_fast_assign(
@@ -199,12 +221,29 @@ TRACE_EVENT(arm_event,
 			__entry->running_state = ~0;
 			__entry->psci_state = ~0;
 		}
+		__entry->pei_len = pei_len;
+		memcpy(__get_dynamic_array(pei_buf), pei_err, pei_len);
+		__entry->ctx_len = ctx_len;
+		memcpy(__get_dynamic_array(ctx_buf), ctx_err, ctx_len);
+		__entry->oem_len = oem_len;
+		memcpy(__get_dynamic_array(oem_buf), oem, oem_len);
+		__entry->sev = sev;
+		__entry->cpu = cpu;
 	),
 
-	TP_printk("affinity level: %d; MPIDR: %016llx; MIDR: %016llx; "
-		  "running state: %d; PSCI state: %d",
+	TP_printk("cpu: %d; error: %d; affinity level: %d; MPIDR: %016llx; MIDR: %016llx; "
+		  "running state: %d; PSCI state: %d; "
+		  "%s: %d; %s: %s; %s: %d; %s: %s; %s: %d; %s: %s",
+		  __entry->cpu,
+		  __entry->sev,
 		  __entry->affinity, __entry->mpidr, __entry->midr,
-		  __entry->running_state, __entry->psci_state)
+		  __entry->running_state, __entry->psci_state,
+		  APEIL, __entry->pei_len, APEID,
+		  __print_hex(__get_dynamic_array(pei_buf), __entry->pei_len),
+		  APECIL, __entry->ctx_len, APECID,
+		  __print_hex(__get_dynamic_array(ctx_buf), __entry->ctx_len),
+		  VSEIL, __entry->oem_len, VSEID,
+		  __print_hex(__get_dynamic_array(oem_buf), __entry->oem_len))
 );
 
 /*

-- 
2.50.0


