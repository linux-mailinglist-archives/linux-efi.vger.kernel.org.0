Return-Path: <linux-efi+bounces-3517-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 17588AA59B8
	for <lists+linux-efi@lfdr.de>; Thu,  1 May 2025 04:36:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C856D3B4135
	for <lists+linux-efi@lfdr.de>; Thu,  1 May 2025 02:36:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 310B81EEA5A;
	Thu,  1 May 2025 02:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="N+51PcA7"
X-Original-To: linux-efi@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11olkn2077.outbound.protection.outlook.com [40.92.18.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36D5B182B7;
	Thu,  1 May 2025 02:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.18.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746066992; cv=fail; b=oP285dI6YfHfQHO086kvstBpwLiyRHXXEbpFZpi5ii24U55q73+HZrkgK/3Df/hY+oCI7jm9xjmtRPnB0O/oo6FSIOwyWZQMMopjmf/KDwNGIo4MQ2i49ycrmUJgJjqQJJ4GB0SjCwJlN3lcXb2c6SqR5tp1Syjq+VqJci9HafE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746066992; c=relaxed/simple;
	bh=Y8SOh+ZgYDhXYT1cskhGkDXiP12qcl8DgwdxWRHWrxw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=VMjoBt8ouZUt1b7XailJbzPfXaXlup7lD55qj9/uWfp8iD6HL97UsIHUdDsJAV24dxAuJUqczboAHv8PAz1OaWe4afnIHdXNRC5kNrWCGU/4GBR44y9fJ8VIOAk79NVpjwBZZOE2iXYRq3me6SlQD06R0KLhj3h0qXTLpU2pW7I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=N+51PcA7; arc=fail smtp.client-ip=40.92.18.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uq1G9+r7/w5eKI3PjocAih8p4+OYnv0Ur6tZ1HXLsEBsRxw7H2mJs6UzwzV5sXE+uuZMX4qnk6Wejcoe7w36aBpeHY09+e8m9WD1VElIGNhieu670mJCQQiLPr201MUDn08fQJNq8DhtuHgdsuO+te0WsKQL+w3EcOlVHHrp2b7s+ajHA40cRpatwlcXt3faP3T/iE2Q0uDZ4Wa2nqtIjBx7laKTRhtVSjQEr3+ok1nszWvQEG9ua5GNMPcD4wFJJsZihJQ5Hm9oylreGds5jeNg28twgKy1zDDLalpqVIs995DM2qp67Uqofk7k2tJ9fm9F4J6cb/WvZKbUsQhNbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y8SOh+ZgYDhXYT1cskhGkDXiP12qcl8DgwdxWRHWrxw=;
 b=nuuvJ7NWpxAxzxjZq6IUSX6KYjFDdeLrNL8b3xvI3vaj+ipFP+OD0YBTIe2CjbinMG0dD5Mt6n3GQnPCXy9QhDAKRy9IH7R9YPTVak/oX+z+2gHCDeh5ogfPVzOPQTkuEhdxSO0jzpTIYXF9mbXENg5vOd3QFPSjECmraJYXx/N5VlqO0ZvdAb3JKYl69k29w5Nv9BgjclM5T3IP6S1AZrDhXoKHC2wlflRaxdSJX/ElpIafkR4dfIMpTq1XnD5JG4Q/my+QMd9E/2SF27Ccr1Rkor8UGc5Pp3TOfQ+xMqnDDmL+MBMJM67ttpDgnitnFc+/+l4FbseATP0dK/No/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y8SOh+ZgYDhXYT1cskhGkDXiP12qcl8DgwdxWRHWrxw=;
 b=N+51PcA7Sj9PiEu0ae7tMjVzlzBxp/PP4SMSdndnmK3Vyjngt5q0ovEUt7ehe45XiKtPx1NyYypUjzZyRwGewcihN6k9NStOAG9gnpLewe0g3vQfRVeg6SQhpNqOlD9CEFM+kEFplkPF3yBH7AjfZg+SJbEIue0NZqXMZQUT7DRvYOqIKG+Izb4uWdNB8UyIWcfsnmdgzZL4yzCZx2wx0dSfQUvbMGTovM13UbvlTk8PMLlxHh+HGFfF+Y+KF6fUNLrNWGbAgiVJTM/furcBhbh1vvjykYTPkT+xdUk601jFWoikZZaTYN/WCG03W9w8lLm1oQL1RLfOerwqP9pN7g==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by PH0PR02MB7350.namprd02.prod.outlook.com (2603:10b6:510:1a::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.19; Thu, 1 May
 2025 02:36:26 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df%3]) with mapi id 15.20.8699.008; Thu, 1 May 2025
 02:36:26 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Peter Zijlstra <peterz@infradead.org>, "x86@kernel.org" <x86@kernel.org>
CC: "kys@microsoft.com" <kys@microsoft.com>, "haiyangz@microsoft.com"
	<haiyangz@microsoft.com>, "wei.liu@kernel.org" <wei.liu@kernel.org>,
	"decui@microsoft.com" <decui@microsoft.com>, "tglx@linutronix.de"
	<tglx@linutronix.de>, "mingo@redhat.com" <mingo@redhat.com>, "bp@alien8.de"
	<bp@alien8.de>, "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"hpa@zytor.com" <hpa@zytor.com>, "seanjc@google.com" <seanjc@google.com>,
	"pbonzini@redhat.com" <pbonzini@redhat.com>, "ardb@kernel.org"
	<ardb@kernel.org>, "kees@kernel.org" <kees@kernel.org>, Arnd Bergmann
	<arnd@arndb.de>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
	"jpoimboe@kernel.org" <jpoimboe@kernel.org>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>,
	"samitolvanen@google.com" <samitolvanen@google.com>, "ojeda@kernel.org"
	<ojeda@kernel.org>
Subject: RE: [PATCH v2 12/13] x86_64,hyperv: Use direct call to hypercall-page
Thread-Topic: [PATCH v2 12/13] x86_64,hyperv: Use direct call to
 hypercall-page
Thread-Index: AQHbucN9umotaZatx0OeVn5Dg618mrO9B6fQ
Date: Thu, 1 May 2025 02:36:26 +0000
Message-ID:
 <SN6PR02MB41577ED2C4E29F25B82548D7D4822@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20250430110734.392235199@infradead.org>
 <20250430112350.335273952@infradead.org>
In-Reply-To: <20250430112350.335273952@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|PH0PR02MB7350:EE_
x-ms-office365-filtering-correlation-id: 249bd7fb-330b-496c-2e34-08dd8858f88e
x-ms-exchange-slblob-mailprops:
 EgT5Wr3QDKyfA/kqhNtxhLoDzMvzACConmAriXbH6QNV6wCiQSOYIwCm8diSDijArey8jy07vniP73ZjsrFm9MmRQi+7txRvSVQMIrlkyuBj9TQtoyxLrYmB9G7Np0lcFX838rZtBhdRiuVa2qrItvydBYAag+rICakIAD3R1PH5vA09omer23OqnY06PEol5MzsnXAPzFO5AyTkuatdJBpZa00qbNLtqw3pNTdJgOuzmIBRtmK21OddoVfkHipuVFTr4L+mp2HMssL9kBtp40I/mlZcSbLZHFsc/wNyMWBZTRjFC+Y1WXCMptlSDX8u/VKz/JarKfszlmG/47h/0l/Qt1P7LxRtKk4rRwzWs21V5gTBCxdvdgSSmP6FHpACMSTFDssY+DaMHsAUBSGjO5ZZ7Bq5Zwh9cuXvLhzR83X+ZQxhaesqlf0F7WPTnTQTPzN0S3iT3cJ1SRV75FqQykw7+yopi+UIV1G/jddwz4/HqFn5QHbIqrpFgZ6g2Fp24U5P/MmpVgHcaVa7x+Txap869Kitaqbr6I0xMUzo+ahtjWIv76tR9Fa1z3wnpk7vqe3MqRyEhPWIEXF0AnqD+Fou9YzgYDYWqv/JJt4TslH7Mciwd7vFmPQ1/08VHxE74/xzBppSPqUviG4UbK9wRecOYVGGHnr857b9hkKPn94Q7Rav5ryHmjaqdEWTzfRoEct6rY8qN9kOr4abIXDl5s436p5bm2KvdluW7uQOrI8=
x-microsoft-antispam:
 BCL:0;ARA:14566002|8062599003|461199028|19110799003|8060799006|15080799006|3412199025|440099028|41001999003|102099032;
x-microsoft-antispam-message-info:
 =?utf-8?B?RXFVZnJxamRGOWxJRDF1azBQUG9CQmZVZGRRZzJCNzNXa1RwSHNQZGg0S05r?=
 =?utf-8?B?ZW1INjF5cC9UekdVd2x6QjdZd1BoVzVwaTZxY3lYOEVHWTFOOXFiSWJkVU1a?=
 =?utf-8?B?UXM4NjU4ODNDVHJYQ2VCRXNlL2NYUWg0Wm5NTVZQUkovb04yWE1hRGMwM0Qw?=
 =?utf-8?B?S1lScDNhelJ4WlVqWENNbTNhMmF3WVNXd3d4OTc3bm12d1orREJQMHJwS3FJ?=
 =?utf-8?B?Q0JmOVRSUUhxNDdiOU1wNXNYeXpQVTVPQ1NSdFo5RGFVMkFjZ3dLZHpTQlRx?=
 =?utf-8?B?RUpyWXpHeFlHZ0V4RkVOa2RmNnhXd2N3Z0RLV2dUZStQZnNSeEtNZFRiay9C?=
 =?utf-8?B?N1lPRlV5Q3diWVlSc0huVWU4bWtPUkNnUXQxYkV4aGNJSHduSUpmTFlFeW5O?=
 =?utf-8?B?blhvbW9nUUdwSzIyenJBcFJmYzBybWV5Z0RyMlB4Um9FNjJobXZLRk9xODhz?=
 =?utf-8?B?Q0YwbXgyTm1SSmRrRk85dXY3dHgrNDU5UUVObVJwNGpNaWpmbTB1TjFwZUpv?=
 =?utf-8?B?OWNLQnpMaDE2cWdKVWs1MTdxOThUeDhyeHNJbDVSL3RPU3l5a1czMytNakkr?=
 =?utf-8?B?KytlMFlrVzdlUEdjcTV2TFRIa1lCOHQwS2Y2TTFHSmhXN2xaSUVjRW5FbXpR?=
 =?utf-8?B?TUFPdm9xaFlYTnZ3eE01bFZvc1RRa2M5aitEb0phUGJNUHNWK2R6SHB4N28x?=
 =?utf-8?B?ODZlS2taQVU2ajlsL3JtdHhJSnJVOWsrVjNUd1ZMdWlFVUsvaU5mODhZYmZ5?=
 =?utf-8?B?WCtSeGVSVXE5bVFHZkwwOXlQMWlpQUdJNGlndVdvdE15M0FFUzdtaU5ZVzRI?=
 =?utf-8?B?ZUlhMjJtMFY5SWIyd3FpVU15ZG4zQW9PdjRmUjlwanpaVGVHa1V0N3dkWWtF?=
 =?utf-8?B?OTBudXA2N2ZFNmZhMkZBVlp6QUlNeHd3N3VaUWxKQlEvUWRkQmd2WWdrTmVs?=
 =?utf-8?B?ZUhqMlFMZmZjeTI1WWNEN2h6VnFWUDRsek5UVnVFaVhRK3BjVmdVMDZ3Vlk2?=
 =?utf-8?B?QTdvbVAzRHpIK25aTmVRemcvSDk4Y3Bkai9aZWFNUk5tOUhnSXJQNnAwZ0M3?=
 =?utf-8?B?T3ZJY0lUbDRrLzNoaE1HYklWYzRNY3FwZjRCWEJBRnFGWjFyNW8vaTN0ejU2?=
 =?utf-8?B?c3J1cUVxbEc3dGwyVXZROXM1OXdWNXRITkY0bmUxN1craUNJSDZyM0VlZ0hG?=
 =?utf-8?B?aGU2bjIwSnFBY1VodkJJWG9CVEUvL1ZjV2sxMEViRHdkSHlvbXgvT1VmQ3hP?=
 =?utf-8?B?SGZvTDBFTHc5bUNvdVZXMmQzQWhtdFZhT1hhWVRkclpNeWxDMExBcXFjRTZ2?=
 =?utf-8?B?RTR4a0YrMjVuN1VaellkVjVIWmw4M3pkTTJNS0REZE43dHQ5a2Ntdk9DUnRy?=
 =?utf-8?B?YXd0ZytMOGQ0SEpRZi9yTGJTdldmMkNzZGxTdjY3b2grOGxDblBxbnhBWXZv?=
 =?utf-8?B?SHI5VGlydDVlZitZWlo5amVISGRwL0QzWjBKWUtmbjNRMzVYZno2dy9Dc1o3?=
 =?utf-8?Q?aF3p/o=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?WVFWZVF4eURPcW1DWjJVTnkxSEQ2MFk2MXk4L2RYam9pbDhXbVFEV2krbmsz?=
 =?utf-8?B?MlN2aGRSZ3huY0U0OUtDblpBR1BON0k3NDFYajdWclQyTkJOdmhvVXV4T044?=
 =?utf-8?B?Mm04eDE5V1hha0Yzd3NoZkRzSGxyVWY0eDJmUC9sQUxOektuZ3lBTG9GWHJ0?=
 =?utf-8?B?dU90blJiV0cyVVIwL3lnZkVKck5FQmRqR09LQ2loQkh0QWxMZ09YNzlPTkVi?=
 =?utf-8?B?cklKdytaN2RMWStGUGUzOTlpdi92RFVvNldYODQ4V093ODRLY1FjaytVQlVJ?=
 =?utf-8?B?Zm9RL3hyWUlGRVhCb2J0Y3RRbnNnSGFvZDFBcU42MUxKeWJPZzZXOVJ3enJ5?=
 =?utf-8?B?VEcxSGRKRzJia2VySVpCSTdIMXRhTXNpMkNubjVnQlVLQzVBSENoZlNPcDVw?=
 =?utf-8?B?MVMxUWNEVVUrUkdCQXNpOHRyZ0NTOXo2WkdDRVVlRUpVTjEySlV4WFlrRDVN?=
 =?utf-8?B?cjRwWVJ2TnpFZGEraU5pbldMWnQ1YWt0a2pRR2hIQ2lLcVNBYm95TWVLa2Yx?=
 =?utf-8?B?eUpyWnNPTDFZUkFaSG4rUlJkYXBhSGJwQmlqc3VmaUdiQnpkb2FVV1NBckNM?=
 =?utf-8?B?NWo0aTlFTUpvVkNneTRROUtnamFSV0JSaThaak5PTE56L3dVSEd6LzhLN2ZP?=
 =?utf-8?B?cm1vYzd1dkE4b00zNUNEbGdnVndYQlNnT1lkUzdwME5tM0QyL05mK0F1dnRD?=
 =?utf-8?B?bGNENmpOR1hCWGZtWXBLeUk4TFZoNGtZN2ZUTEQxY2RNQUczMDNjamplR2xs?=
 =?utf-8?B?d2krVk5tcXpWQjdHRmJCcHJZRHdoK1FMQzlSb1RpU3FDNHFtdFVWK1RCdisw?=
 =?utf-8?B?emhoZmNPT0pxczlScVNBN245MTdWKzl6YXEwMm5IQTU5bmM3dGFiVWN0L0Zt?=
 =?utf-8?B?dXIwVSsreXNSTnk3OXV2TEZuRDdIQzZnVzZmTXU1YUN6L2JBbW1vaUZxM05X?=
 =?utf-8?B?bFpIbGZhZm8xZEVLbVZ0TS9jUGhSZGs2Um5XTTNnQXBpZERteWljelFRb0x1?=
 =?utf-8?B?SlVFQ1dvQ2d6Vm1UdDFZR3NyVDFoTUJ3Qm15elVTNTZMS3ZSTFZoeGpKZEtk?=
 =?utf-8?B?UlM1S01aMXZseUJLZHJhU2I0bnhvOTZDY3JQaEtHblRVQlROV2k0ZStoRlBo?=
 =?utf-8?B?NklLbXZrK1dpaytiU0xWOGw3d0lVZWd0YXhkQVR2TWRRVzlIL09nV01xQmFh?=
 =?utf-8?B?VFU0SzhDcE5OajJvMDZ6emhSbHdGRk9XRVFmR2JONWFtcENscjM3ZUdOWUc1?=
 =?utf-8?B?c1YrQ3JkY0FROEhqNnJwMmJBM0xvNUswTHR5U0xwaEEycFI1QkQxVGk5ejU5?=
 =?utf-8?B?aWkydys2b2R1a2ZNZE1tQSs1aFR5Y1RkZjluZ0dGZkRyS0ZJQmRuUFVXbTU0?=
 =?utf-8?B?NWlNODdLMGREbTdkMmhQTXJ6cWtCeitYckYvMk1zeFoycGs4cHJKTjlOSDVF?=
 =?utf-8?B?dVg5K1IwYzJIaXVpQi8ycHJpbkJRcy9ia1BWek1Rb1hmVTlaRFRtRFB4a3ov?=
 =?utf-8?B?eVlha1puYzVmYWZybVlEaFg1ZzJFdmtlbmZoL3FHZXl5NTE1eGpBVkN1cXQ2?=
 =?utf-8?B?YkV6YStuYkhwTzFNNk9yNTZOTTdaeHdZclByRnhIN25leS84VURkUWFPQUFr?=
 =?utf-8?Q?PsTPaVFPuJ9fXHyOWBjSzAbIaeOTlX+/Dw1Wc1zl2geA=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR02MB4157.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 249bd7fb-330b-496c-2e34-08dd8858f88e
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 May 2025 02:36:26.4647
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR02MB7350

RnJvbTogUGV0ZXIgWmlqbHN0cmEgPHBldGVyekBpbmZyYWRlYWQub3JnPiBTZW50OiBXZWRuZXNk
YXksIEFwcmlsIDMwLCAyMDI1IDQ6MDggQU0NCj4gDQo+IEluc3RlYWQgb2YgdXNpbmcgYW4gaW5k
aXJlY3QgY2FsbCB0byB0aGUgaHlwZXJjYWxsIHBhZ2UsIHVzZSBhIGRpcmVjdA0KPiBjYWxsIGlu
c3RlYWQuIFRoaXMgYXZvaWRzIGFsbCBDRkkgcHJvYmxlbXMsIGluY2x1ZGluZyB0aGUgb25lIHdo
ZXJlDQo+IHRoZSBoeXBlcmNhbGwgcGFnZSBkb2Vzbid0IGhhdmUgSUJUIG9uLg0KPiANCj4gU2ln
bmVkLW9mZi1ieTogUGV0ZXIgWmlqbHN0cmEgKEludGVsKSA8cGV0ZXJ6QGluZnJhZGVhZC5vcmc+
DQo+IC0tLQ0KPiAgYXJjaC94ODYvaHlwZXJ2L2h2X2luaXQuYyB8ICAgNjAgKysrKysrKysrKysr
KysrKysrKysrKystLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDMw
IGluc2VydGlvbnMoKyksIDMwIGRlbGV0aW9ucygtKQ0KPiANCj4gLS0tIGEvYXJjaC94ODYvaHlw
ZXJ2L2h2X2luaXQuYw0KPiArKysgYi9hcmNoL3g4Ni9oeXBlcnYvaHZfaW5pdC5jDQo+IEBAIC0z
NywyMyArMzcsNDEgQEANCj4gIHZvaWQgKmh2X2h5cGVyY2FsbF9wZzsNCj4gDQo+ICAjaWZkZWYg
Q09ORklHX1g4Nl82NA0KPiArc3RhdGljIHU2NCBfX2h2X2h5cGVyZmFpbCh1NjQgY29udHJvbCwg
dTY0IHBhcmFtMSwgdTY0IHBhcmFtMikNCj4gK3sNCj4gKwlyZXR1cm4gVTY0X01BWDsNCj4gK30N
Cj4gKw0KPiArREVGSU5FX1NUQVRJQ19DQUxMKF9faHZfaHlwZXJjYWxsLCBfX2h2X2h5cGVyZmFp
bCk7DQo+ICsNCj4gIHU2NCBodl9zdGRfaHlwZXJjYWxsKHU2NCBjb250cm9sLCB1NjQgcGFyYW0x
LCB1NjQgcGFyYW0yKQ0KPiAgew0KPiAgCXU2NCBodl9zdGF0dXM7DQo+IA0KPiAtCWlmICghaHZf
aHlwZXJjYWxsX3BnKQ0KPiAtCQlyZXR1cm4gVTY0X01BWDsNCj4gLQ0KPiAgCXJlZ2lzdGVyIHU2
NCBfX3I4IGFzbSgicjgiKSA9IHBhcmFtMjsNCj4gLQlhc20gdm9sYXRpbGUgKENBTExfTk9TUEVD
DQo+ICsJYXNtIHZvbGF0aWxlICgiY2FsbCAiIFNUQVRJQ19DQUxMX1RSQU1QX1NUUihfX2h2X2h5
cGVyY2FsbCkNCj4gIAkJICAgICAgOiAiPWEiIChodl9zdGF0dXMpLCBBU01fQ0FMTF9DT05TVFJB
SU5ULA0KPiAgCQkgICAgICAgICIrYyIgKGNvbnRyb2wpLCAiK2QiIChwYXJhbTEpLCAiK3IiIChf
X3I4KQ0KPiAtCQkgICAgICA6IFRIVU5LX1RBUkdFVChodl9oeXBlcmNhbGxfcGcpDQo+IC0JCSAg
ICAgIDogImNjIiwgIm1lbW9yeSIsICJyOSIsICJyMTAiLCAicjExIik7DQo+ICsJCSAgICAgIDog
OiAiY2MiLCAibWVtb3J5IiwgInI5IiwgInIxMCIsICJyMTEiKTsNCj4gDQo+ICAJcmV0dXJuIGh2
X3N0YXR1czsNCj4gIH0NCj4gKw0KPiArdHlwZWRlZiB1NjQgKCpodl9oeXBlcmNhbGxfZikodTY0
IGNvbnRyb2wsIHU2NCBwYXJhbTEsIHU2NCBwYXJhbTIpOw0KPiArDQo+ICtzdGF0aWMgaW5saW5l
IHZvaWQgaHZfc2V0X2h5cGVyY2FsbF9wZyh2b2lkICpwdHIpDQo+ICt7DQo+ICsJaHZfaHlwZXJj
YWxsX3BnID0gcHRyOw0KPiArDQo+ICsJaWYgKCFwdHIpDQo+ICsJCXB0ciA9ICZfX2h2X2h5cGVy
ZmFpbDsNCj4gKwlzdGF0aWNfY2FsbF91cGRhdGUoX19odl9oeXBlcmNhbGwsIChodl9oeXBlcmNh
bGxfZilwdHIpOw0KPiArfQ0KPiAgI2Vsc2UNCj4gK3N0YXRpYyBpbmxpbmUgdm9pZCBodl9zZXRf
aHlwZXJjYWxsX3BnKHZvaWQgKnB0cikNCj4gK3sNCj4gKwlodl9oeXBlcmNhbGxfcGcgPSBwdHI7
DQo+ICt9DQo+ICBFWFBPUlRfU1lNQk9MX0dQTChodl9oeXBlcmNhbGxfcGcpOw0KPiAgI2VuZGlm
DQo+IA0KPiBAQCAtMzQ4LDcgKzM2Niw3IEBAIHN0YXRpYyBpbnQgaHZfc3VzcGVuZCh2b2lkKQ0K
PiAgCSAqIHBvaW50ZXIgaXMgcmVzdG9yZWQgb24gcmVzdW1lLg0KPiAgCSAqLw0KPiAgCWh2X2h5
cGVyY2FsbF9wZ19zYXZlZCA9IGh2X2h5cGVyY2FsbF9wZzsNCj4gLQlodl9oeXBlcmNhbGxfcGcg
PSBOVUxMOw0KPiArCWh2X3NldF9oeXBlcmNhbGxfcGcoTlVMTCk7DQo+IA0KPiAgCS8qIERpc2Fi
bGUgdGhlIGh5cGVyY2FsbCBwYWdlIGluIHRoZSBoeXBlcnZpc29yICovDQo+ICAJcmRtc3JsKEhW
X1g2NF9NU1JfSFlQRVJDQUxMLCBoeXBlcmNhbGxfbXNyLmFzX3VpbnQ2NCk7DQo+IEBAIC0zNzQs
NyArMzkyLDcgQEAgc3RhdGljIHZvaWQgaHZfcmVzdW1lKHZvaWQpDQo+ICAJCXZtYWxsb2NfdG9f
cGZuKGh2X2h5cGVyY2FsbF9wZ19zYXZlZCk7DQo+ICAJd3Jtc3JsKEhWX1g2NF9NU1JfSFlQRVJD
QUxMLCBoeXBlcmNhbGxfbXNyLmFzX3VpbnQ2NCk7DQo+IA0KPiAtCWh2X2h5cGVyY2FsbF9wZyA9
IGh2X2h5cGVyY2FsbF9wZ19zYXZlZDsNCj4gKwlodl9zZXRfaHlwZXJjYWxsX3BnKGh2X2h5cGVy
Y2FsbF9wZ19zYXZlZCk7DQo+ICAJaHZfaHlwZXJjYWxsX3BnX3NhdmVkID0gTlVMTDsNCj4gDQo+
ICAJLyoNCj4gQEAgLTUyOCw4ICs1NDYsOCBAQCB2b2lkIF9faW5pdCBoeXBlcnZfaW5pdCh2b2lk
KQ0KPiAgCWlmIChodl9pc29sYXRpb25fdHlwZV90ZHgoKSAmJiAhbXNfaHlwZXJ2LnBhcmF2aXNv
cl9wcmVzZW50KQ0KPiAgCQlnb3RvIHNraXBfaHlwZXJjYWxsX3BnX2luaXQ7DQo+IA0KPiAtCWh2
X2h5cGVyY2FsbF9wZyA9IF9fdm1hbGxvY19ub2RlX3JhbmdlKFBBR0VfU0laRSwgMSwgVk1BTExP
Q19TVEFSVCwNCj4gLQkJCVZNQUxMT0NfRU5ELCBHRlBfS0VSTkVMLCBQQUdFX0tFUk5FTF9ST1gs
DQo+ICsJaHZfaHlwZXJjYWxsX3BnID0gX192bWFsbG9jX25vZGVfcmFuZ2UoUEFHRV9TSVpFLCAx
LCBNT0RVTEVTX1ZBRERSLA0KPiArCQkJTU9EVUxFU19FTkQsIEdGUF9LRVJORUwsIFBBR0VfS0VS
TkVMX1JPWCwNCg0KQ3VyaW9zaXR5IHF1ZXN0aW9uICh3aGljaCBJIGZvcmdvdCBhc2sgYWJvdXQg
aW4gdjEpOiAgSXMgdGhpcyBjaGFuZ2Ugc28gdGhhdCB0aGUNCmh5cGVyY2FsbCBwYWdlIGtlcm5l
bCBhZGRyZXNzIGlzICJjbG9zZSBlbm91Z2giIGZvciB0aGUgZGlyZWN0IGNhbGwgdG8gd29yayBm
cm9tDQpidWlsdC1pbiBjb2RlIGFuZCBmcm9tIG1vZHVsZSBjb2RlPyAgT3IgaXMgdGhlcmUgc29t
ZSBvdGhlciByZWFzb24/DQoNCj4gIAkJCVZNX0ZMVVNIX1JFU0VUX1BFUk1TLCBOVU1BX05PX05P
REUsDQo+ICAJCQlfX2J1aWx0aW5fcmV0dXJuX2FkZHJlc3MoMCkpOw0KPiAgCWlmIChodl9oeXBl
cmNhbGxfcGcgPT0gTlVMTCkNCj4gQEAgLTU2NywyNyArNTg1LDkgQEAgdm9pZCBfX2luaXQgaHlw
ZXJ2X2luaXQodm9pZCkNCj4gIAkJd3Jtc3JsKEhWX1g2NF9NU1JfSFlQRVJDQUxMLCBoeXBlcmNh
bGxfbXNyLmFzX3VpbnQ2NCk7DQo+ICAJfQ0KPiANCj4gLXNraXBfaHlwZXJjYWxsX3BnX2luaXQ6
DQo+IC0JLyoNCj4gLQkgKiBTb21lIHZlcnNpb25zIG9mIEh5cGVyLVYgdGhhdCBwcm92aWRlIElC
VCBpbiBndWVzdCBWTXMgaGF2ZSBhIGJ1Zw0KPiAtCSAqIGluIHRoYXQgdGhlcmUncyBubyBFTkRC
UjY0IGluc3RydWN0aW9uIGF0IHRoZSBlbnRyeSB0byB0aGUNCj4gLQkgKiBoeXBlcmNhbGwgcGFn
ZS4gQmVjYXVzZSBoeXBlcmNhbGxzIGFyZSBpbnZva2VkIHZpYSBhbiBpbmRpcmVjdCBjYWxsDQo+
IC0JICogdG8gdGhlIGh5cGVyY2FsbCBwYWdlLCBhbGwgaHlwZXJjYWxsIGF0dGVtcHRzIGZhaWwg
d2hlbiBJQlQgaXMNCj4gLQkgKiBlbmFibGVkLCBhbmQgTGludXggcGFuaWNzLiBGb3Igc3VjaCBi
dWdneSB2ZXJzaW9ucywgZGlzYWJsZSBJQlQuDQo+IC0JICoNCj4gLQkgKiBGaXhlZCB2ZXJzaW9u
cyBvZiBIeXBlci1WIGFsd2F5cyBwcm92aWRlIEVOREJSNjQgb24gdGhlIGh5cGVyY2FsbA0KPiAt
CSAqIHBhZ2UsIHNvIGlmIGZ1dHVyZSBMaW51eCBrZXJuZWwgdmVyc2lvbnMgZW5hYmxlIElCVCBm
b3IgMzItYml0DQo+IC0JICogYnVpbGRzLCBhZGRpdGlvbmFsIGh5cGVyY2FsbCBwYWdlIGhhY2tl
cnkgd2lsbCBiZSByZXF1aXJlZCBoZXJlDQo+IC0JICogdG8gcHJvdmlkZSBhbiBFTkRCUjMyLg0K
PiAtCSAqLw0KPiAtI2lmZGVmIENPTkZJR19YODZfS0VSTkVMX0lCVA0KPiAtCWlmIChjcHVfZmVh
dHVyZV9lbmFibGVkKFg4Nl9GRUFUVVJFX0lCVCkgJiYNCj4gLQkgICAgKih1MzIgKilodl9oeXBl
cmNhbGxfcGcgIT0gZ2VuX2VuZGJyKCkpIHsNCj4gLQkJc2V0dXBfY2xlYXJfY3B1X2NhcChYODZf
RkVBVFVSRV9JQlQpOw0KPiAtCQlwcl93YXJuKCJEaXNhYmxpbmcgSUJUIGJlY2F1c2Ugb2YgSHlw
ZXItViBidWdcbiIpOw0KPiAtCX0NCj4gLSNlbmRpZg0KDQpOaXQ6IFdpdGggdGhpcyBJQlQgY29k
ZSByZW1vdmVkLCB0aGUgI2luY2x1ZGUgPGFzbS9pYnQuaD4gYXQgdGhlIHRvcA0Kb2YgdGhpcyBz
b3VyY2UgY29kZSBmaWxlIHNob3VsZCBiZSByZW1vdmVkLg0KDQo+ICsJaHZfc2V0X2h5cGVyY2Fs
bF9wZyhodl9oeXBlcmNhbGxfcGcpOw0KPiANCj4gK3NraXBfaHlwZXJjYWxsX3BnX2luaXQ6DQo+
ICAJLyoNCj4gIAkgKiBoeXBlcnZfaW5pdCgpIGlzIGNhbGxlZCBiZWZvcmUgTEFQSUMgaXMgaW5p
dGlhbGl6ZWQ6IHNlZQ0KPiAgCSAqIGFwaWNfaW50cl9tb2RlX2luaXQoKSAtPiB4ODZfcGxhdGZv
cm0uYXBpY19wb3N0X2luaXQoKSBhbmQNCj4gDQo+IA0KDQpUaGUgbml0IG5vdHdpdGhzdGFuZGlu
ZywNCg0KUmV2aWV3ZWQtYnk6IE1pY2hhZWwgS2VsbGV5IDxtaGtsaW51eEBvdXRsb29rLmNvbT4N
Cg==

