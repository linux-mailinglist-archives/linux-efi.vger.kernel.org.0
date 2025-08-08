Return-Path: <linux-efi+bounces-4522-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E680B1EEB2
	for <lists+linux-efi@lfdr.de>; Fri,  8 Aug 2025 21:03:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B0FC5A2CEF
	for <lists+linux-efi@lfdr.de>; Fri,  8 Aug 2025 19:03:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA8B52874ED;
	Fri,  8 Aug 2025 19:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="K9e9HsNf"
X-Original-To: linux-efi@vger.kernel.org
Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11022107.outbound.protection.outlook.com [52.101.53.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2896E21CFEF;
	Fri,  8 Aug 2025 19:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.107
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754679794; cv=fail; b=cGtbJnDDTzGeGW+PdW1G0doEtqi12eYZoyYbdCd1TwQAZ22k5ladl2VPZ7kJJCX3feFl4ncStLU3+Xh8sEFopEx33QqaT9Ks+V2II7OejOXIGkQA6EfQGMH/B1dajXzJMFW858pJD74tQY9sK1EmplJMlr1bpJPJEYz3swHpCLM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754679794; c=relaxed/simple;
	bh=6kOh9rbkOzQ1hdOHn3v1D/P7p12K2AbSAHqVAs4bnzs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=S3kliI6XstJe4rNuEhlugqpljTv/0P+SW9qYyQtrIp4VpGLEgi9xUcAQibOncIlohywRWzjvje4GVjTcNMjTC5vfQdx38w3/GzDr1gmVZXd/VCJdFdQjTox0rOOVVRY5Wwln2rLOLoytAP0payddzjLmc3JwGxZHP7W83HUeZoE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=K9e9HsNf; arc=fail smtp.client-ip=52.101.53.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q4b3LRrFSQ2IAG/heV36mC2bYxN/nYf+OZzdNP18t0AoOmMDjLicRCYB9cPve05zYQtGBtKWRZ7wdBg92KSYjWQhp0aGmlPS+6XO/GMLuXQ1Jk9PeAMAeMUeDr5ohuafE0EBDwIMHyWUAji+UZSzrYnbE+IQcTvBAjVT0AEC2dc8UzoigGNtZPinAWGHAkeFMrz22jO7GeR9OE3BXzGOh42Ehm4xP34NSUQ31hypoXUxmA5dUUzBoCMG2AywmgUaoOvpAl9LJHUkjXLIneu+1+UbEDeXRy/SZcWHgAhcX4u3ja7R9QKXngS7ObmZiJMpBop720dpvxzmDmV8N1nT+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WpheuPZd8cYuZSAToDuNHfyVhaj6NPO6wg4EcbuGOGE=;
 b=OwSUMrayhH5i+0orP1/uwlRbsHTQ4QK7HuwbnotM30+Uu7GxFA+kCsU+ceGIlyolqlIo9f76qFunYWVRa8JAsGUtgj04Tswd3uowDz5lE6HvJW0oHXshQuF6ulSItbd7Hi/ZQiKxlG6x4lV0cKXpfmbqA/SGitn8SY40wF0FXCHAtoX5P1atvXU5INd/A9uLh7YeFhokCFTqg3BYPz6YRjYaj0UI/tBeNoijKZwlispRpkl/biO7CEDCAdn1ZqjUZxcqyLeveqo6NLwfM8bn/o/FgS0pOWHec/1KEBe14RQTy2d3NWsPINEdjVHb2akW5VEL+/5VjbuDl/ouC89r5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WpheuPZd8cYuZSAToDuNHfyVhaj6NPO6wg4EcbuGOGE=;
 b=K9e9HsNfKiaYxOVyVLSEOOg1RxfGZ150JX5uwzj8lJjV2mRhUFAyeyyERKXtW3+hCGtvehZd0kRPd2o+GeBX4RaYFqJdf5lYJtMA79pwaoHMQ5Cdd3bLeypwOlDyHkQIZMIh/lO0X4DrmLbjYXqAukoq5JmXIlVpgZ8tJdWm550=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from SA3PR01MB8473.prod.exchangelabs.com (2603:10b6:806:397::12) by
 PH0PR01MB7350.prod.exchangelabs.com (2603:10b6:510:109::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9009.13; Fri, 8 Aug 2025 19:03:09 +0000
Received: from SA3PR01MB8473.prod.exchangelabs.com
 ([fe80::46d7:1d3a:dc9c:69c3]) by SA3PR01MB8473.prod.exchangelabs.com
 ([fe80::46d7:1d3a:dc9c:69c3%6]) with mapi id 15.20.9009.013; Fri, 8 Aug 2025
 19:03:09 +0000
Message-ID: <4499042f-e1e0-4fe6-8670-4556a3f4a88a@os.amperecomputing.com>
Date: Fri, 8 Aug 2025 12:03:06 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/5] Fix issues with ARM Processor CPER records
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Ard Biesheuvel <ardb@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
 James Morse <james.morse@arm.com>, Tony Luck <tony.luck@intel.com>,
 Borislav Petkov <bp@alien8.de>, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
 linux-efi@vger.kernel.org, linux-edac@vger.kernel.org,
 Jason Tian <jason@os.amperecomputing.com>,
 Shengwei Luo <luoshengwei@huawei.com>,
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 Shiju Jose <shiju.jose@huawei.com>
References: <20250805-mauro_v3-v6-16-rev2-v4-0-ea538759841c@os.amperecomputing.com>
 <385eca9a-0366-4f3a-95cf-6f19101957ea@os.amperecomputing.com>
 <20250808160121.000038bd@huawei.com>
Content-Language: en-US
From: Daniel Ferguson <danielf@os.amperecomputing.com>
In-Reply-To: <20250808160121.000038bd@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR02CA0030.namprd02.prod.outlook.com
 (2603:10b6:303:16d::18) To SA3PR01MB8473.prod.exchangelabs.com
 (2603:10b6:806:397::12)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR01MB8473:EE_|PH0PR01MB7350:EE_
X-MS-Office365-Filtering-Correlation-Id: 5ff87af9-e145-48ac-979c-08ddd6ae36d8
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|52116014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WWwxWkVoeGxyN2Z3aWVyVmR4NC9aUTM4U0JRckZGQjU1QXpLc3daWVhHU2tY?=
 =?utf-8?B?WG0rVGJycVlxSnRQQmYwU3lHbnVJUEZ0WFdpY0NYUWVMd1AwbzIyUVd5RHUr?=
 =?utf-8?B?Q3ZkVE55ajJhNkFGUm04cndYNzFkd1Q2SlU0endOL0ZUSWZIL3RvUnFNTS9L?=
 =?utf-8?B?NnMzM3pxQ0pKQm96TjJzWFh2dVUvRTU0YXd0MUg2TXdDL2dHeFRzYmRjeVFX?=
 =?utf-8?B?RjlUM3JlRUR0QngxTDB5UWhJckJRc291RVBVMTZtaGIzaVRGSS9EUWgydXBu?=
 =?utf-8?B?SW9RZG9vL05oQ3RncmU1R0JvL2hvbSsrMENXOWh1ZFFzd056NWtHQlhURGlZ?=
 =?utf-8?B?TnRFdk9nNDFnZjdRZFkyaWdjVmluNllGWjZHTVcrU251am8rN3ZOMWc0eE1z?=
 =?utf-8?B?SXl3TXpxbXVsc0JQa1kzZnowcTVSYk5RYlJtN1N1YjlsRCtUUkg4aEhuMTg4?=
 =?utf-8?B?cGJtSlBzOXhIRzZSeVRoUEhYUW9HSURkSC9WU2dnT215dnVyMnFtdkpodnZ0?=
 =?utf-8?B?KzdNMm5sUFU0bmZoYnRocW5EU3hPUHg2ZGdHcEo0K2RYbkZ2YzdsbWFza3ZY?=
 =?utf-8?B?elczWXV1ZTNRRm5iY05rci82dW5FTDd4bWJBejZOQnVjaC9xc2xsQy92NG9Q?=
 =?utf-8?B?SW84S0E2YWc5WS9GRm83Mng3YWM1WjVoNEFreDR1RE95dTk5SVA1N3dZS0p4?=
 =?utf-8?B?eWtQZ2w2aFUzYklDK04zZEFzYlJvUS92eUpGMHVIN20yOWd2QnNqbGZyT045?=
 =?utf-8?B?WFZUeisvWUFFUGlpMGxJNFcvUjFNWUltOXFpeThZRHVnYXFyLzVUeXpiYmww?=
 =?utf-8?B?Mm50dVZQWHhjbmVWMXBtaDB2Y0xWSGc0ajJhS1k4d2VZU0VFMXozTlJORm1j?=
 =?utf-8?B?bGNDL3dGQzhmWk1yZDQwby9MWVd2aExJeW9iZDJtTlU4a2pjS1pKMUFoWnJR?=
 =?utf-8?B?aFJ4WkFQM0tWQWg5a0gzd3o0OGM4KzhabmhKdlQ3ZUFPV05GTVZ4d2FSQ0Jy?=
 =?utf-8?B?anh5L3Jmb2FSdmlDakd0R1BPQnlqQW91ZEEybytzSSs2RUdSRk16aEd5QXFZ?=
 =?utf-8?B?SHdIM0RZZE41dUhJNUlyTjEzWVY2QkpxWWZGR296S1B3MCs2eFc1WldRbTJD?=
 =?utf-8?B?aGhBVTd6NTBWVG4vSzI4djFSWHBOR0kveXJ1blRYWWNaVVhDWE95Uys0M2s5?=
 =?utf-8?B?Yy9VaVhwNnJ6TTJUbkxkWUp5akp3ak9zdFF0eGRKRVpDSVRCZkZKT3YzOHBW?=
 =?utf-8?B?aUg4QTVud1gvWVladmRyUHNIbUNpSFhMRFJ6SFZTMVVKMmU0djg3UUwrLzIw?=
 =?utf-8?B?WjRtZXhqOTVTWGdHa2ZjTFBlVjFvL29SWlJtc3Vwa3BKcGpoa2tIYncvMmp6?=
 =?utf-8?B?cUlCczdaZE5QT1lUTzIzQ3NiQVh2cnlKUVZhMEpMa3hwWCtRQWo3M1IzSnd1?=
 =?utf-8?B?dk4wUEpKN0JlOTRTejMzbTMrbXRpRDlUNmtqOUZiVUJQeHZJbEZFQ3BrYVY4?=
 =?utf-8?B?SllhZ2NoemR4N091OFBCWVlvMUZTWjZpWDZycGViYXo3b0NuZkdjOTIxYXFJ?=
 =?utf-8?B?RHFuNkZnMFVZc2dHQ0tERnZvc1NaOGMyemNXZEMwQzdmMW82Y0p6aE9VVHBC?=
 =?utf-8?B?aEdaMU5nYXRWa05mclFGRGQ4V1VTaWxNSmNMQmx5emZ0Y2NqV0ozUWpPNVg3?=
 =?utf-8?B?UHRsbHhSTERtMTdoaGwwT3R5RFNMQkt0RW5vVUhzUGM2OGxBL3JhOERKTVBT?=
 =?utf-8?B?MTRJNDBZMmEwSE1jV3pyNTVlN2Y5S2JRTU1FTVBKVk83dnFuNzlITkZMNE9K?=
 =?utf-8?B?TzFRNmQ3MDd4clFVK0RZRkdvU0xvOU52ZzA4b2FqN3BLOEdjL2VnQ0VvY093?=
 =?utf-8?B?Q1R5akJMc3RjQ3pjVUV4a3J3MEhGL3JCM2RuV0Z5T2VqbVVtSlJNTlJ1TlBF?=
 =?utf-8?B?clFaTHNjTUIxRDBZNFFERHVCWEJlU2pKU1JwNDlQOHM4VXkzK2ExVWZTeUdh?=
 =?utf-8?B?aUhnb1ZSMU1nPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR01MB8473.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(52116014)(366016)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aVQ2RFE4TjMvc0p3RVlUTGlTOXhxU3Z3bTcwQWJ0bGRUSExiNUNWaElwbjE4?=
 =?utf-8?B?elBpY2x1cFpVY0I1OXIrbzFhNTlmNlhjK1ErMk5SNVREZjVwN0tmV0J3Q2Vr?=
 =?utf-8?B?M0Urb0RDTjFpSVJpbzFwUlU5MEhEamw1TUYyd3V1b0p4OG5xdDl0N2EydmJR?=
 =?utf-8?B?T29XL3lZZmdTMXphSkRTd0NBZmFZT0VlTjBwWlh3UWdLSXNiN0VKY01JLytq?=
 =?utf-8?B?cllCV204SmpBUXBSSUNyNGVMQ2hxVk8wL3RPTHVxMkFQQ25wNjV3TGcyN0c3?=
 =?utf-8?B?ME0xaFZJMWlCeUV2NE5mUWJtYjBmenBqeWphdHpRRWZmY0REaHY4dm5Zcm1I?=
 =?utf-8?B?YTZJcTNJcFlIYXprdEI0TDhjaDdGN1YzMVVNR0ZSelVGak41YlJwZXhqVXFT?=
 =?utf-8?B?ZjVUMlA0dWtEUVFGZXBpYk4wRjE3bmhYTno2VitKam1yUEZ2VjRqQTBqZnZq?=
 =?utf-8?B?M2xQQjBLaStkNy9pK2VmYUhZLys5anczeWlub1kvK053MjJuYkJzODdtOHJX?=
 =?utf-8?B?Q2EvY1U5V3BxejdFZERsZXoyVWFQdkwzZ3VJdWRXMFRCOFQxRjhJZjQ4alla?=
 =?utf-8?B?Zk1kSFBtLzVGQVpacjNXV0dTRHlEWWxQbmwzQitUVTg1V3IyMkRNMWh3ZUQv?=
 =?utf-8?B?VzBMb3lESDBFbGIySlBKRENnRGxDUllYNE1WeGlJVHNPVTRwaWl6NW5NWVZC?=
 =?utf-8?B?ZXNUUHo5Q05BMEhvclNpZEtSNU1yTy95ZE9zdklJbmZTenVROUdKeTNwdTE2?=
 =?utf-8?B?YlRpSEhUa3F6Sk9ESVNsdzVkZGpRNi9ldnI4dEtqTGNzemhERmQra0lIaVBa?=
 =?utf-8?B?bndUUFVycEtoc0hGWUYvWnB0Q3A1SHkwK2M3ZDR5QXFPcjRsZFI0Ly85ditC?=
 =?utf-8?B?bThqWWJuVU1nc3JMVEQyRFNJQVdVK2lyZDdDQ25wQ0N5Y3JZT0Uwd1FRM25M?=
 =?utf-8?B?V0hWMEhYT3ZyczhUcUoxRUMyem41WTJhS2NoN3liN3pMRzRvNVVWd1dGY1J6?=
 =?utf-8?B?WjI5Q25DUGxYWTZNb1R5VTdlcWxTL1V1Y29VNG0xUGJnNjZlNHVpWjM0RG5y?=
 =?utf-8?B?RTQrWlhGejBUK3dEMmZHSElYc0FJNit0VTI3QUQ3VG9Dbzg1eDZ0ZXMrc2Ev?=
 =?utf-8?B?NzA2OEl4M2FXdVJiNklaMmVURWVjSzF0R3pkVFdvTUlMZ3ZJMDhOM3M2eG9l?=
 =?utf-8?B?dWJEalJLQU0yM3prbEZrRWN6MUdjemMrVXB4V2oyQXQ3Rit3YWllK3dzMUNk?=
 =?utf-8?B?aEhhMUtJUHpPMnQrS2Y3ZzBRak1GbU8yblNRa3hLSmNnMVRDVWsyL1NEU3dI?=
 =?utf-8?B?TnJCNmdRcEMxZzdiTVJaN29LdkZoRnZJNGxlcS94aXhzcFlKR0g1aWlNT3Ev?=
 =?utf-8?B?THBwby84WUhJME43Qk5BL3dqUlFxQmZhT3U3VVZnQ2xjcEw5THlrQVRraktn?=
 =?utf-8?B?cjJZOXNWdkpLdWMvZWF4UHJSZElZeHdwb1MvRE1sUFR4SmxzSFZhWHpFM3d5?=
 =?utf-8?B?YTJkR285TVVUOVRIMitpWnMweUppY0lTUWNVSUNlWDBPQmdqaEpOVU82UjU2?=
 =?utf-8?B?UHhpYW52ZXE1MTZNTTd5UGtwUThCQ1BPREVsMncvdy9ZZTBKOTl1Y1hzSVRC?=
 =?utf-8?B?MnV0SDlpYlhUL1QrdC9MTS9WdXRQVDdnc2tGNUpoM0VlU1RNTGwrT0wwRFRL?=
 =?utf-8?B?MFdYb1V0ZnAraFE4NWhXQVgrMmo1RzYzVG8wRFBhb1FONFh0dTlrWWVJc0Nt?=
 =?utf-8?B?MDBSaE1KQlhINW9KaFZoYWNQb0gzY3hCVnQ5ck42ZXRENm5WN0s5T3J0V1Q3?=
 =?utf-8?B?SEtRNFh0U25kbDdqUmNwZzJ3eHJKTWFoMktVaXZyckZ5Ty92Y01YY2NEcEtK?=
 =?utf-8?B?LzdtNUNEWnE3cUp2WmpZWFVhcHJSdG1qRFJqdHhFV0xCTFZCQzlSSlFURmo0?=
 =?utf-8?B?Wmx3ckxhYzl3Nm1qQTRObHhqeWtLZ3pqNGltTWkzTG4vamZkQ2QraGl6eklx?=
 =?utf-8?B?R0MwR0xSaTZTbnpCZmZEZ0FyWGsrNEMzU3Q4S2g0eGV0c2I3UWNHMnNMSVpO?=
 =?utf-8?B?YVd5SThuWmQvK01QcUFBc1BGZGM3bjJJVkt1SThnQ2JFcnFlZytic2JjQ2lh?=
 =?utf-8?B?UEZaUUwrV0NaQlE3RkhkWko2bCtiZzQ1Z0pDRExIcEIrNHdHUVdSKzFMUHlJ?=
 =?utf-8?Q?rK7OcIklfpLM+kAKApU/UXk=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ff87af9-e145-48ac-979c-08ddd6ae36d8
X-MS-Exchange-CrossTenant-AuthSource: SA3PR01MB8473.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2025 19:03:09.2347
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PV1vRXuStfzkZoBryY2TqzNyMC9Jjop4IQyY07Uhg/A77K7DifTgGkZyb15ksk5uHD7aljYZElvSTk+LGrHb9tlj/KkqCRCgp6E3KNINvMVVA3dJGALkrEZ/k83E6yer
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR01MB7350



On 8/8/2025 8:01 AM, Jonathan Cameron wrote:
> On Tue, 5 Aug 2025 11:39:38 -0700
> Daniel Ferguson <danielf@os.amperecomputing.com> wrote:
> 
>> On 8/5/2025 11:35 AM, Daniel Ferguson wrote:
>>> [NO NEED FOR INTERNAL REVIEW, THIS IS JUST A TEST]  
>>
>> Yes, PLEASE REVIEW...
>> I accidentally left that message in...
>>
>> ~Daniel
> 
> Hi Daniel,
> 
> No problem with you picking this up to take forwards as I gather you asked
> Mauro first, but good to mention that change and that it's with agreement
> (or not if it's abandoned code which I don't think this was.) 
> 
> Thanks,
> 
> Jonathan

Hi Jonathan,

I didn't ask Mauro directly, but I did ask this list if my intervention would be
useful. I was given feedback that it would be.

When I resubmit this patch, to take into account your feedback, I'll be sure to
also explain in the cover letter the change of hands.

Hopefully I didn't step on any toes, that wasn't my intention.

FWIW, here is a link to the brief conversation that led to the hand-off:
https://lore.kernel.org/linux-acpi/CAMj1kXGSNT08QrCp1jazmi9ANpZ7RCuS4kHo9x6hwxtp6z0Nhg@mail.gmail.com/

Regards,
~Daniel

