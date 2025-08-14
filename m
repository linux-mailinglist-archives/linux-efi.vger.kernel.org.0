Return-Path: <linux-efi+bounces-4553-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A30DB26D11
	for <lists+linux-efi@lfdr.de>; Thu, 14 Aug 2025 18:56:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1321AA03DAB
	for <lists+linux-efi@lfdr.de>; Thu, 14 Aug 2025 16:53:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C89231FE444;
	Thu, 14 Aug 2025 16:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="Q+W5Uml2"
X-Original-To: linux-efi@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2136.outbound.protection.outlook.com [40.107.94.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA18A163;
	Thu, 14 Aug 2025 16:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.136
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755190388; cv=fail; b=f92YgDuj/KaK2I2YVzLAVnIZ7Q8v+Yncgb+b9tM/BEItSEnuBPX34vj+AKlf3MqWwkknJJFg0AsVjhkveXuN/C/nn+KfyD4kl454+F1W2AtOstLeteOX5WOlUQ1TMcpKVDZ7pnMA0jEKmBETGC8mVdY0HILI7walTMt3WC1OUWk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755190388; c=relaxed/simple;
	bh=1BR96P5CsoWg69avPYORujksrth3Y5fM9hWDjc/JymI=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=tNGOuf0s3eW2CRUBajRc9T2qN7tNuYgS4lhFRrlqxW4evO0GMLrxVOsr7bc5/34MP7+D8/uH/LgCd5scQsL6A0UNFqxe3F3OoG78W5QGzUVckXL0XLi/Nr+UniLCWk9fgrjTjdwck7/Ghduwt7qzFhUIrlBj7VPL985+WPPtWGw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=Q+W5Uml2; arc=fail smtp.client-ip=40.107.94.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X+YGxTKwrQLUa1U3ArBPumFGV+DJaq4HjOUN3YOApEu0K2vdIWA8ySW23vbl5ZLEqI7sr5Kkzw2lH9XQfkZtxjxoGN5RHwRRxHaGH5csNCRfs9OBcD37K7jsDdPl4T235cCskz5OPM7aTJ1OiOpBgEMPLblcsZu2hoi6zNenba301BNnA8iAu6HF5biD+Y1/MxWsVckgoezZWXYZhO8sJJivgdc/P52kngQgWRP5f0Pk+ACvVpGIbfqYNmhYgUXxNO4d/JLCK+4viLTXWtvCwCyU2R0EFIxUY6BDUbP/PxK2Ga9xrL50FeR9ym5N1u9zoEe9sFto0xP352S4exma5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lfAfWV70BJJ74A5f32wZbAjWB10Xxu8ntbnIEJNOSCk=;
 b=YTCjLbU/weIJAik+Z59HsbOVeYlXWPonD4KB2KzSyM8mjW22i66B7wFtaqtjK+9oi9PIhII5MZqo7jpPmy30xX9LIBfdO5UYYF23pKFMdyp7hGCD/bI44UBczVwc4rTHEvsSHiarU59SLkgl06CfZmZd0hlAvYPHu3/qeoGcUaLq01peNU2GdIPH5LUv2pqW2Y29hr7IWucB/cFGOvLYAbrpB4HyyOn1z9R1MjGw65MGkDniOSlUWfTqnu8cF/NQ6hpeo0SveLDmJugHwta9cYiifXxoYNWcFsUpmu3yPLs5EFaMXwyJEo4QIYJ9nSTsgXZ2iQP7P++Ec/uPQNOk1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lfAfWV70BJJ74A5f32wZbAjWB10Xxu8ntbnIEJNOSCk=;
 b=Q+W5Uml2KlNo60xWqZjBlFrggA6BWQ2ZfFXZqLwouktUtI5M02sldYpjsKDekGOi7ry/AB82nYPr1BvPvOZZ9gL7d24HCJ68wYT4/LbJTyAeGs2l0NCYKL0+LVFUmGcAz6VhQVtcgMQYBEPd+ZFXZTF5oVVfd3EJiVTa74IGbMY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from SA3PR01MB8473.prod.exchangelabs.com (2603:10b6:806:397::12) by
 BL3PR01MB6881.prod.exchangelabs.com (2603:10b6:208:354::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9031.18; Thu, 14 Aug 2025 16:53:00 +0000
Received: from SA3PR01MB8473.prod.exchangelabs.com
 ([fe80::46d7:1d3a:dc9c:69c3]) by SA3PR01MB8473.prod.exchangelabs.com
 ([fe80::46d7:1d3a:dc9c:69c3%6]) with mapi id 15.20.9031.014; Thu, 14 Aug 2025
 16:53:00 +0000
From: Daniel Ferguson <danielf@os.amperecomputing.com>
Subject: [PATCH v6 0/5] Fix issues with ARM Processor CPER records
Date: Thu, 14 Aug 2025 09:52:51 -0700
Message-Id: <20250814-mauro_v3-v6-16-rev2-v6-0-e5538d534aa0@os.amperecomputing.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGMUnmgC/3XNTQ6DIBAF4KsY1sWA/Ihd9R5N0yCOykIxoKSN8
 e5Fu+nC7ua95H2zogDeQkDXbEUeog3WjSnIS4ZMr8cOsG1SRgUpBCkZxYNevHtGhqPEVOK0KTC
 rlORKNiBIjdJy8tDa16HeHyn3NszOv48nke/t11NEnHqRY4JBC6ZKUSlOzc2FXA8TeDBumJbZj
 l2eLrTjUfyAlJ2DIoGV4E2tjGlrkH/Bbds+yRUIyxQBAAA=
X-Change-ID: 20250731-mauro_v3-v6-16-rev2-3986486de50b
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
X-ClientProxiedBy: CH5P223CA0006.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:610:1f3::23) To SA3PR01MB8473.prod.exchangelabs.com
 (2603:10b6:806:397::12)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR01MB8473:EE_|BL3PR01MB6881:EE_
X-MS-Office365-Filtering-Correlation-Id: 2a81ab89-c33d-400e-5b6e-08dddb5306fc
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|7416014|376014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aDU0Wk5UUU5FYVFtdnJQVEZPYW9RVHFWbnM1MGE0dXJqOUxVK3d2T2s0R0ZO?=
 =?utf-8?B?T2NXRHZhQmgrMGsxNDRpV3ZTVW1ZSlp5bzN6ek5pdXQ2aDl0RVRGaHAwV3Vr?=
 =?utf-8?B?WEhBRWE2TWpLcHNVcUVQWUtoR2s4U2dpRGZwL2lkYitUem9Kek82Uis3T1pJ?=
 =?utf-8?B?YTIzUnNPUnI5T1lrbU9ERkN6WlQ5cGxTcHpCWEVYZzNhcmxvRXJBbWlvb1Ew?=
 =?utf-8?B?YVE4QlBXYjV1NDlUY3VpWVZCd2EzTjVNdm12ZS9odGRyNElJTERwbitsSnRG?=
 =?utf-8?B?NlRDUDhKZzd5RllhNUhqNkNKUWJUSGYvVkl1dkRacHRMSXpJRUhCL0hWL0lJ?=
 =?utf-8?B?S2JkME9mTFdkTkZ2emw0VFcyaHMwYjlIN3VqR3VZek90a0k3dzFQLzcvd3lk?=
 =?utf-8?B?ekZZMXVucFJua0Z2am1aTGI5YlF5Qk9qazBVL1RNSDM0a0lrUDIrb1QydGQ0?=
 =?utf-8?B?RGFqUlZmdE5kK1RqOWxTeGV2dXJTU0FKQlExd0dpaExLNmtxY0U4WTdXRXFP?=
 =?utf-8?B?aUJ3WDlSZGFtUzhXL1c0YnpUeDZNSWFNa2VHbHRzMEx6ejNIdHh5UENyU1Qz?=
 =?utf-8?B?OUJ4cEV1bVhSTGpwSEZNU1kxcEN3RkZMYUU5N2JCQXU3cWpFaDEvVEJXQlBJ?=
 =?utf-8?B?aDYyWnVoOVFmVGNlK1V4ZDhxb1daVnVwRzJ6d0Rlek9Dbk1RajgrTzJNNzJ4?=
 =?utf-8?B?ZVpmSVYvN05JU20xc2JTTkROUkttdzR6RU92M0JKV2dOQmhzSjFtcHRGa25S?=
 =?utf-8?B?bENYaWpwaUZ3ZU1jYWJhcHRuZTRPaXZHTDdkRFZqMEpKaXVNZllwZk84RGlE?=
 =?utf-8?B?YTQ4NUF3ODdrK0VSWVZ2QzAvMkc4dUZacGhhbFhmZUxaWlZzL1UrcE5mY3VH?=
 =?utf-8?B?R2NKY2ZDMzNNWlRPb3pUMzMvcTJJSHlSTDg3N0xNN3JNV1VTcFk0NFJJWTQr?=
 =?utf-8?B?SDZCb0lGMC9XeWgzb29WM1drTTVWQWVEZVFiZVN1ZzhJT1lSa1hydSs4RHJ5?=
 =?utf-8?B?YWlvckVpNmVkTVc4bW5tVjlJZjJtYzF0dTU3TUZhOUpKYWxaTk8zREcvOW9J?=
 =?utf-8?B?OWJNSzFSTU85aUNZUkg2U1NYYmVSNi9MZWhmeUFNOGhjUGdSa2Z2NzdKdnlR?=
 =?utf-8?B?MDdLbytvUEFwV1BkcDViNUFoUUhRWU9GelRUZyt6RDN3VHg3NW9DZ0ZqYW5Z?=
 =?utf-8?B?M1ptZUFkMEFlbTE3L01XQjdETU5Yd0V5K2gxSzZVaDFMekxna0lYSGpTOU0z?=
 =?utf-8?B?UmpzNi82dHhJUS9IOHlkakFnYUJyd1c1TnM0ejFhWlhYNDBBK1p4L3Jjc1VB?=
 =?utf-8?B?YzhlbFpDaWJJRVhzVVZqK2hGTStUMndUYk5RQnd2NGIxOHc5Q3Q1a20zTno0?=
 =?utf-8?B?WTBNTXF5eXNzWitPRDNuc1dVZDFXZXl5U3g2NC90bTgxcHZnUW1vclVCZENH?=
 =?utf-8?B?MGhBYlJEQ25KazZocEFJVEFwWFNLVzJ3OUl4bzE1SERRT3JkR01jVHlMcTEv?=
 =?utf-8?B?eU9ueCtFWnNsSlluUVgwMzZDM2tzd2tQWTYwd3JyZU9ManhDRWZMUXEzQnFS?=
 =?utf-8?B?bkF5NTA2anRXSkoyNzFwNGNVRFRaNDRYdXl1WVRoVEVGRDFYbUN0eUh0bERO?=
 =?utf-8?B?NExIRnU1QlJDN29VQ1l4aGZOTkN1eTZxYU94bzFXS0Jmd2F0QTFKM3JIbHl2?=
 =?utf-8?B?MVhaTnBHbjlIYUhKQ2x5NmQ2LzVvbXlDd2FKWXp6R04xQml0N0RVV1VQMWZh?=
 =?utf-8?B?S2ljd0hCbFBVKzlGOGRXMGtvWlFIK0ZlUG0ra0NkeitIeDlDcW5mWTJqcjJH?=
 =?utf-8?B?dFVIMC9sTFV4NVNVcExpc0N6SSs2V3BFTUVBbEZGNkFiWlRaZzJBSWsyY1p1?=
 =?utf-8?B?d2hCZkdZR3BMZ2tJa0NjdzhadEVSWndzTUNTQjNyVUUySEdYNGFicGhGR2Vw?=
 =?utf-8?B?SnN4cXc1Y1IxYkVUajdJTUhnL1Y0bkhWUzROTDl1bEgxc1kxcjBLMUE4MVZY?=
 =?utf-8?Q?v+cL3roE069xx0eXSIVPnXCCnodPlc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR01MB8473.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(7416014)(376014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TlNuTjg2S0xaS0dESm5pakNyRDJOdlRwc2U3dGRMM0t1NEd2djE3eHByaVdN?=
 =?utf-8?B?QzJoRFpIVEVqQ1VIdFNNWmpYdGFDN3d6aEJyZjVOOVkxR0VENkVUWE0zYWJR?=
 =?utf-8?B?bmlhLzFkOU9INUJBTUR3VUQ5VXE5U3Z5ektvaGRETytZQVhxeGYvSG16QVVY?=
 =?utf-8?B?UUpQcC80TzRYRHRrM3RFU1JCU2dtSlBkTTBueXpicURTWWlHRU5GTmRCejd4?=
 =?utf-8?B?YTAxMWV3TEdjQnlYblNUc0R5alFTVGwvTnJXaXIwNUMzbURDM0RJUjlXQUYy?=
 =?utf-8?B?T0NvWlFxL1pGbUNiS3hmcTBqdlZXNERsUWRUa0JNMTNxOHpiRGRqM2VrUkNx?=
 =?utf-8?B?RmEwdzB1eG9xenhGVk1ZTXBPRjVCclR6QlJVcXNGcmUzR3NWdFZKenpSZkJB?=
 =?utf-8?B?NjJBWWtEZENLY2g1SGU0djFiNVh2VUxBeVRkTFB5ZDdRaURyZm5zVzJRZzBH?=
 =?utf-8?B?bG9GcTk5bUdhL2FwZUhzRUY2T2g1V01HNGFuRk16U08yYVk1ZDRvRWtBY204?=
 =?utf-8?B?WE1XZllDOTZFS05CSUFNVDc4KzdHZ3AzYXBjSGxZeEZYL1plQ2xQdTlpWVB2?=
 =?utf-8?B?OWdzam9tcFRPZ2tDb3psVnBMZDZNV1dodkZjQnh6bXdpRnNXVVNrWjVVSjcv?=
 =?utf-8?B?YmJDTFMyQXcwOTJIb24vZVpGUk90MWhlVDFLUHkyU2pJZi9mZmlqaXZhRGpQ?=
 =?utf-8?B?OEh1Tkg0WG15MzBXQlNJVGh0YThOV0JYcTdHT0Y3anVGNmEwNk9PZ1RQQUl0?=
 =?utf-8?B?SE50Uzd0cGNMU3NHWmp1b1dudngxOWNxdEwza3EzcVNFOWxJV2FmQWZpakNk?=
 =?utf-8?B?YkcrbnJPdDEySlppSlN6YThTZUNmNE5IY1B6RDBHVUNzUHd5cy9jaURQS2dQ?=
 =?utf-8?B?MjdqVWI1RU5LT1o5L2VzSlQwTU9BU0NQb1JaelpHT0taakwrc09aQXBXaWpW?=
 =?utf-8?B?US9BZ0YyQkJUVzYyVWNZRHRtYzVpNTFtRGw0QkVzTi9wZDY0VmRaYzV2QUs5?=
 =?utf-8?B?Qi9iaTFoZUEyMUtCTFNPanJrZ2REeEc0TC9LaWFKSDRjeG5CbThvOUNvSnhW?=
 =?utf-8?B?Mk5CeXdpa1FucHA3ZUVncUpFbVNKalloSHdtdEhLcC8weTVXUXQ5djgreWNZ?=
 =?utf-8?B?MzFzRXFvTytuMGllaXc3OC9JcFJFaGtnckU4UUlKM3FMWDgvdENMNzlnVFpm?=
 =?utf-8?B?Z1NhQk9BMXpwOXpLMUM0WmVmZ0p2eW9iZ3QyN0JUeTBaWng4eEh5UjFPa0JB?=
 =?utf-8?B?MlI1L0ZWMHhtbWNaYmdvWHpxT2VPOCtYWXRMZDJaV2Y4UnBrMG9ubzBBMWdY?=
 =?utf-8?B?cWpUVTBRM1d0cngyaklWMkRIa3hmalRwa29Db21XZW1yMU9VdWthVFJES2Q5?=
 =?utf-8?B?am1SNElEYjAvRlAzYitxZGl5WDBRNDIxUkVtOXBNdXUrN3FzVFRYZjZYZnRW?=
 =?utf-8?B?alovem1iWFZOYVRHN0pYTXFtNVZXRm5xaHVyOUJvSmFqY240Q1dvc2Z1dzQ1?=
 =?utf-8?B?a1RSci9GWUE3N1lrV1NsYnVpemR3Y1FkUzFvWFhBdDNaNHY0dmtBN3RHYjBU?=
 =?utf-8?B?ZXcxRGVsWXhCai9XNzhPbkFKdFJBNEZNSjJ0azZ4ZGRVUEU3Q2VWeithVXcz?=
 =?utf-8?B?Qmc2Q1NoS1B3cXVKa2VyaGhjWnJJcXEzTEt0RlRqWFM1RWRXMGxYV3VTeDZr?=
 =?utf-8?B?bzVUcUFJVlczdmk5dVRYYkF3WE1PNXJWNkhTY2owWjJtNUVEUnIxUk9jZmRZ?=
 =?utf-8?B?QllHYXdlS05jZi90MTg3YW1paXIzSGNObktwRDR6ZXA3UlpKUENLV0NMUUYv?=
 =?utf-8?B?TXhTeTQrMkpGYmhHZEhVVlpPR0JjYmcxejFha0VJN0I0bzJNWEZGU21BL0gx?=
 =?utf-8?B?Rlh6cW85NjJxL09SMzYxc0pJWktVb3NIY0E2a2wrak9wWFhKbDF1STRudDIr?=
 =?utf-8?B?UEt4YlBkTVlLY0N2WEpsSTQybWxRN2VOQllTTFZIU2syeXBEQjZFTUkwY2U5?=
 =?utf-8?B?WXh0WVF4Q0tTLzlnakdpTWZYZWMyUTVEREtvQnZvZmZyZlU3ekJ4N0h5dXBW?=
 =?utf-8?B?N3N1d1h2K0xBK1N2VDc1TUhYT2FTZ1BHSHpjYWxmdHh0bjkrbVlTdXFjVmlh?=
 =?utf-8?B?aWFEVUU5YXFJS3FQMVF3cElEc3BhSUNEdXA3STI2TjlXQWZDdzB0d0VKZHg1?=
 =?utf-8?Q?1tGur/zOVXzyEfbvzlonNjg=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a81ab89-c33d-400e-5b6e-08dddb5306fc
X-MS-Exchange-CrossTenant-AuthSource: SA3PR01MB8473.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2025 16:53:00.4642
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4DDCvhlrh5VxWk22+Xf+NLadnAhyW/8v9nQ7Mi8tpkA7Q62t/c1A9Q6RUeOxlmJ9rrF5FzhsXHZdcAAS4MPsb+UWOVX9ukN+9qkC9dW3DAEmM5TnIcVMHkHlnOK80X/7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR01MB6881

This is needed for both kernelspace and userspace properly handle
ARM processor CPER events.

Patch 1 of this series fix the UEFI 2.6+ implementation of the ARM
trace event, as the original implementation was incomplete.
Changeset e9279e83ad1f ("trace, ras: add ARM processor error trace event")
added such event, but it reports only some fields of the CPER record
defined on UEFI 2.6+ appendix N, table N.16.  Those are not enough
actually parse such events on userspace, as not even the event type
is exported.

Patch 2 fixes a compilation breakage when W=1;

Patch 3 adds a new helper function to be used by cper and ghes drivers to
display CPER bitmaps;

Patch 4 fixes CPER logic according with UEFI 2.9A errata. Before it, there
was no description about how processor type field was encoded. The errata
defines it as a bitmask, and provides the information about how it should
be encoded.

Patch 5 adds CPER functions to Kernel-doc.

This series was validated with the help of an ARM EINJ code for QEMU:

	https://gitlab.com/mchehab_kernel/qemu/-/tree/qemu_submission

$ scripts/ghes_inject.py -d arm -p 0xdeadbeef -t cache,bus,micro-arch

[   11.094205] {1}[Hardware Error]: Hardware error from APEI Generic Hardware Error Source: 0
[   11.095009] {1}[Hardware Error]: event severity: recoverable
[   11.095486] {1}[Hardware Error]:  Error 0, type: recoverable
[   11.096090] {1}[Hardware Error]:   section_type: ARM processor error
[   11.096399] {1}[Hardware Error]:   MIDR: 0x00000000000f0510
[   11.097135] {1}[Hardware Error]:   Multiprocessor Affinity Register (MPIDR): 0x0000000080000000
[   11.097811] {1}[Hardware Error]:   running state: 0x0
[   11.098193] {1}[Hardware Error]:   Power State Coordination Interface state: 0
[   11.098699] {1}[Hardware Error]:   Error info structure 0:
[   11.099174] {1}[Hardware Error]:   num errors: 2
[   11.099682] {1}[Hardware Error]:    error_type: 0x1a: cache error|bus error|micro-architectural error
[   11.100150] {1}[Hardware Error]:    physical fault address: 0x00000000deadbeef
[   11.111214] Memory failure: 0xdeadb: recovery action for free buddy page: Recovered

- 

I also tested the ghes and cper reports both with and without this
change, using different versions of rasdaemon, with and without
support for the extended trace event. Those are a summary of the
test results:

- adding more fields to the trace events didn't break userspace API:
  both versions of rasdaemon handled it;

- the rasdaemon patches to handle the new trace report was missing
  a backward-compatibility logic. I fixed already. So, rasdaemon
  can now handle both old and new trace events.

Btw, rasdaemon has gained support for the extended trace since its
version 0.5.8 (released in 2021). I didn't saw any issues there
complain about troubles on it, so either distros used on ARM servers
are using an old version of rasdaemon, or they're carrying on the trace
event changes as well.

---
v6:
 - fix typo in Jonathans "reviewed-by" in patch 3
 - Link to v5: https://lore.kernel.org/linux-acpi/20250813-mauro_v3-v6-16-rev2-v5-0-954db8ccfbe6@os.amperecomputing.com

v5:
 - fix a few code formatting issues
 - remove "Co-developed-by: danielf" because his/my contribution was
   removed in v2.
 - adjust tag block
 - Link to v4: https://lore.kernel.org/linux-acpi/20250805-mauro_v3-v6-16-rev2-v4-0-ea538759841c@os.amperecomputing.com

v4:
 - rebase to kernel v6.16
 - modify commit message of patch 1, and adjust white spaces
   per Boris' suggestions.
 - Link to v3: https://lore.kernel.org/linux-acpi/cover.1725429659.git.mchehab+huawei@kernel.org

v3:
 - history of patch 1 improved with a chain of co-developed-by;
 - add a better description and an example on patch 3;
 - use BIT_ULL() on patch 3;
 - add a missing include on patch 4.

v2:
  - removed an uneeded patch adding #ifdef for CONFIG_ARM/ARM64;
  - cper_bits_to_str() now returns the number of chars filled at the buffer;
  - did a cosmetic (blank lines) improvement at include/linux/ras.h;
  - arm_event trace dynamic arrays renamed to pei_buf/ctx_buf/oem_buf.

    

---
Changes in v6:
- EDITME: describe what is new in this series revision.
- EDITME: use bulletpoints and terse descriptions.
- Link to v5: https://lore.kernel.org/r/20250813-mauro_v3-v6-16-rev2-v5-0-954db8ccfbe6@os.amperecomputing.com

Jason Tian (1):
      RAS: Report all ARM processor CPER information to userspace

Mauro Carvalho Chehab (4):
      efi/cper: Adjust infopfx size to accept an extra space
      efi/cper: Add a new helper function to print bitmasks
      efi/cper: align ARM CPER type with UEFI 2.9A/2.10 specs
      docs: efi: add CPER functions to driver-api

 Documentation/driver-api/firmware/efi/index.rst | 11 +++--
 drivers/acpi/apei/ghes.c                        | 27 +++++------
 drivers/firmware/efi/cper-arm.c                 | 52 ++++++++++-----------
 drivers/firmware/efi/cper.c                     | 62 ++++++++++++++++++++++++-
 drivers/ras/ras.c                               | 40 +++++++++++++++-
 include/linux/cper.h                            | 12 +++--
 include/linux/ras.h                             | 16 +++++--
 include/ras/ras_event.h                         | 49 +++++++++++++++++--
 8 files changed, 210 insertions(+), 59 deletions(-)


