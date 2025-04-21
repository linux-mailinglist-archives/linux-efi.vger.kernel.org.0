Return-Path: <linux-efi+bounces-3397-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6978A955EB
	for <lists+linux-efi@lfdr.de>; Mon, 21 Apr 2025 20:29:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3BC15169A91
	for <lists+linux-efi@lfdr.de>; Mon, 21 Apr 2025 18:29:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33B261E9B1B;
	Mon, 21 Apr 2025 18:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="GjqKki6C"
X-Original-To: linux-efi@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12olkn2107.outbound.protection.outlook.com [40.92.21.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BE3214883F;
	Mon, 21 Apr 2025 18:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.21.107
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745260129; cv=fail; b=otAyESXnDYIuo7P/A7Z4sl6lbXOREyx+ckpSgrmfUd1ICFZxfR+B1ZFXA5P6CZS0IcpKllfl2ycglBBqfEwiYtCHzY4d1GX8GKs9si+1KmBH7iNTo18n5znrbTIPHN6fkBXEdkP6zufypYZeFtIsKGJgrmd8C0NnqLYHPYmy4Jc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745260129; c=relaxed/simple;
	bh=1zDXQ1ETooAjE7++nmUou1UDRuCZ4DHyIE7DXEevAB4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=VaMXqOlaG1CLj5G/JVnaIUvAUC64f3lIq8N0+gTwZPchoaicuYiCS6sR29raz+WlpjaSNvuMycuVL6E2WHvwsQYeXggdqPXOr6WNtBHSWX1Kt3oRSDr+fto3tB1argzLJ5AAZROc2XB0FaUh2YT2fxNEgZm2yMfKNneuoftv1JE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=GjqKki6C; arc=fail smtp.client-ip=40.92.21.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HqcPdW2RCCWgvO1aMTtZT5uQh8ccw5puAt5ZSoN3jxGMv9CRFpl63nhA5klqMfnRs04M1CRyKUVrk1CAiPqBfkzXSJ7sPDnSLXrKbiUZmjVieCIStkeFLkdBOigtosT3mKhFknpPezXAE2m43pp5hRkln8K7hhEZaDHp9q01ntNU68rmTQuZCQVBnDVHT0Yv1rDr4aIeVed5stdMyKcBqMQzjm+YSzoIVR/1m2nIsnFMknM8UdfTC0veGydbkRpcBuNb0r0Fqc4hxcNC6zXmbo/MViZd/ZXW9SPEdTVx+tqUjBoEpvidUNL/RMkH0aBCwY3OoQLNEXilC5IbR/t5BA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1zDXQ1ETooAjE7++nmUou1UDRuCZ4DHyIE7DXEevAB4=;
 b=AHCNTG4EXuB8Zki0aAqo+OYI/Gy9d7Dk6tikf5YN+wheoaajxcOsF4hvdDSB4hKLbPUTxcdJfxL7eLAP0Hf/uQWC5BUBshp/GQWpdRZ8q4ksIXRdcGKda+9PfdWIkqoRijSs3m/zcY7ix7Lgjgh9kqXEJHz0L/xedO/wyMazxw47u89gn67dlHBVaKlXDNiNg07pXjn+7NEvuTj7R/jJbyJbPYRpXdinzarxaQx2gENMNxxBJ16kxmx2yzBmInEl2aKdQu7PSSuG0tV2+Hg04hDB/TFZ+koFKmrS0seY5hSYnGnOoVnLVCHa4NzD6IX7cTwF0153m5P06Z/U6aPCsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1zDXQ1ETooAjE7++nmUou1UDRuCZ4DHyIE7DXEevAB4=;
 b=GjqKki6C+Kg2lLxCzn0HgVnmklLd+VGSbWDm80ACjnrLCpWX14HmJZptLw/wkfDmvyZA0kCcWKZNGY3IQaVHLnd1h45pllnlRWyMk4gL79ZridlLzx3dVBEK/4VxxSj7L8PXY/41fisZ8FxLAOOcmtGw4hPVqt4Rpkt5A2HXxFnZR3gQYUKT428yYo62AsnR+n36fPq8XM/mIh98YTyG1xr4iXaeqDAPzHI/XgyTMW+SvbnDHbbRTwJivt9IdL9zk8Xa22iNjZii0XkuI8Tp0OPc6+1pFR+SC6doX3K18Ul2hxsN/7SwTZsGh6lwErHeS6I356xYODp1XFLyYnEY8Q==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by PH7PR02MB10028.namprd02.prod.outlook.com (2603:10b6:510:2eb::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.21; Mon, 21 Apr
 2025 18:28:42 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df%5]) with mapi id 15.20.8678.015; Mon, 21 Apr 2025
 18:28:42 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Peter Zijlstra <peterz@infradead.org>, "x86@kernel.org" <x86@kernel.org>
CC: "kys@microsoft.com" <kys@microsoft.com>, "haiyangz@microsoft.com"
	<haiyangz@microsoft.com>, "wei.liu@kernel.org" <wei.liu@kernel.org>,
	"decui@microsoft.com" <decui@microsoft.com>, "tglx@linutronix.de"
	<tglx@linutronix.de>, "mingo@redhat.com" <mingo@redhat.com>, "bp@alien8.de"
	<bp@alien8.de>, "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"hpa@zytor.com" <hpa@zytor.com>, "jpoimboe@kernel.org" <jpoimboe@kernel.org>,
	"pawan.kumar.gupta@linux.intel.com" <pawan.kumar.gupta@linux.intel.com>,
	"seanjc@google.com" <seanjc@google.com>, "pbonzini@redhat.com"
	<pbonzini@redhat.com>, "ardb@kernel.org" <ardb@kernel.org>, "kees@kernel.org"
	<kees@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	"gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>, "linux-efi@vger.kernel.org"
	<linux-efi@vger.kernel.org>, "samitolvanen@google.com"
	<samitolvanen@google.com>, "ojeda@kernel.org" <ojeda@kernel.org>
Subject: RE: [PATCH 5/6] x86_64,hyperv: Use direct call to hypercall-page
Thread-Topic: [PATCH 5/6] x86_64,hyperv: Use direct call to hypercall-page
Thread-Index: AQHbrTIaLjXb7HTpjEywClCcZeg3ibOudLWA
Date: Mon, 21 Apr 2025 18:28:42 +0000
Message-ID:
 <SN6PR02MB41575B92CD3027FE0FBFB9F3D4B82@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20250414111140.586315004@infradead.org>
 <20250414113754.435282530@infradead.org>
In-Reply-To: <20250414113754.435282530@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|PH7PR02MB10028:EE_
x-ms-office365-filtering-correlation-id: db48bf3a-c44d-444a-a455-08dd81025830
x-ms-exchange-slblob-mailprops:
 EgT5Wr3QDKyfA/kqhNtxhLoDzMvzACCoWPJDUsdTyeX0DbLMKydJWVn32qJPDb+9zktnN9EdLZgRrUnitrAa74buLEDm8nGh7FHGDEQKs5iv8nTSh/AkH1JK6Fbc1RWGpuP2l1XvElCR8vU59vlTVcMf/ajuMCQP7EVzQS1TTMz73m/72pTwFIYDeN2qUts2UV1UfD5vaOh60a8cD/dGfxO6+LFFQiRSesnV0GoCFoWKhBlpCbUzI9TLtkOSWnSHoRi/nTCtAM1/AbFZVsYlehSoSqCYHww79Drj0+keKzTlTs4ALPzhCPCRp0ZT9tnX3EaMArgkKZKPJ2TaG8VO2vaq/XsG3wl7Gz/aQqEVfWMaCPbXGNutHv72hD4dWwjYNoxW47nYGcSBeoIztnWha6MCLrKZuUHmcc2gxeI0e+YURHTSI4VWl5h1FuIyloNUzXez25lmMqU4ufste7X2oDiCMcQrfeBU6B1n+XnW0q5UI2qYwQKnwv8D4cXcC1RIkq8JC3UEV+Ztj29XJj33sQYTVGNaJAkHV/0f7auIKq2kQ272+c+SxWQNaWIH5vaotHWYPwNs72FsPfO4wyJ4cLJ31OHDJyX77TYVx9+rCcwwb21A8vQoAszK33CBs15qLFbZu4Q5yAOilw/NP7Kl1YpSyoSURidn99RLgA6y/qXjCyqZNH8zVhrJ68dqGS1DIllBgNLDIj2VN7dYfYAB0OGpYy7HSab2QDh7XaC5v9s=
x-microsoft-antispam:
 BCL:0;ARA:14566002|19110799003|461199028|8060799006|8062599003|15080799006|102099032|3412199025|440099028|41001999003;
x-microsoft-antispam-message-info:
 =?utf-8?B?bC9laTQ0Tk5Yc3dmSURzYkp6WEJ1KzEwOXFzQ1IvVTFKUVZEMXJCZlBTZEdD?=
 =?utf-8?B?ZnROUjd0dm1wSjhqT3BxYStFZm01T1dxeTlBZGN2TEpVdk9pb2lySGpuOE03?=
 =?utf-8?B?cGJWcDUrOUlzVFpHTnJWdk14ek1RTVJ1SlZiM3V3Q1IzMHpuL2FPT1YxSDdE?=
 =?utf-8?B?VjBxaVhQek1uK0hzTm1OWHZtaDJZSHhYandWdVdmT2lVQXpkbnlKbFpVQVdD?=
 =?utf-8?B?ZmVRZUh3WEF2RE1nYlMxMjVqVFoyeGVEZXVmbkNTYzhRZXBDc2pVbDBkWkJv?=
 =?utf-8?B?SjNWM2hIVXBCUTJ0eVJqL3cxRFJEVGpEWXlvK1N2S3BJQzUvR1ovUVdidjJU?=
 =?utf-8?B?cEdPUGhCU2w3Rll6SFcrV0dqL1Y4akt0RVFFVW81V1BoWS9OVTVHOWlwVmpI?=
 =?utf-8?B?MjhzL2VZc0xjMy9iZFAvRzVaVlVxMEd5WnZ1QkxEbnVDT1BvaVFpRVZQb1FE?=
 =?utf-8?B?YnlqV3puQUdjTTFZekhiOGtSTm11STI3V3B3MHRqUkZ3R3FpeExUZHgyVlkr?=
 =?utf-8?B?ZEtUM0FDWHZqYWNodzFsaUo0OWNaWE4rLzRvYjZ2eXRvV1E5QXB1T3lMa1Ji?=
 =?utf-8?B?QVVFVGxkcXNpdGFnNWxBWkU0SFY3bGVzcHlya01IdkN1RFdWNlB2ckd0d1NP?=
 =?utf-8?B?dlVlNGZLMEpzbXl6SGlWN3BUc1hqNTd3VjB0eXFKa1dUWjBjTG5aRCtiUlVp?=
 =?utf-8?B?Zk5nSlQrTCt6NVlaVy9LUW8vSmU2Wi9qNE9qTXBtZzlhR014K2lMdE5BQ1Q2?=
 =?utf-8?B?VVNWci9NZVE5NE1rL0Q4QTNFYUkzVE5KWkRTNk5LSWxVZ2JJdGo5SytCeXBh?=
 =?utf-8?B?eGIzODErckhrUm1kbGpabTR4amFxTS9oZG9TaEQrTnBtbHdBQzdJa044alhQ?=
 =?utf-8?B?endrcFZYMmsraWFUZC96WVdMbDNVZnJWTC9GS1dYamVPMURtdWVRNzcvbm05?=
 =?utf-8?B?YXJnbjAwMTRFd0FXcmZ2bEF1VmlpZ2dFN3pCTHdZVEN5aFltZ0VjZm1BeUhS?=
 =?utf-8?B?Z2o4MXZHRlBuYUtsT0dvZUh4SzMvUG9KMTNzZUZRajFpUDVUdmkyN2ZxcXUx?=
 =?utf-8?B?YmtXM2l3a1hQNEZzY3JmR3I5MkFZM1lwd203TlIxQlRCcWRxYlh3dmZaRGZ2?=
 =?utf-8?B?NTlESTZhODZSYlZSRWYzZWJSbHZMaWwvTXcwa2RXQUlzaHdzS2RiQnhhZ1dt?=
 =?utf-8?B?OUF3UjlWWGRPekVaQmJoTFk4N01UbitIVEsyOXhaZzhVcjVqY21vcFdXcTZZ?=
 =?utf-8?B?dFM0U2o4TVhXVW12cFpLUkE5ekJpR09GZkRSVWJQeUQ2QmdVdkFNbStZZWly?=
 =?utf-8?B?dzEwZ2VjdFRwcWtEc2JGVEtDKzhDMDhYR29ESXZNZ0NveG5QeXd6Yy9xUmRK?=
 =?utf-8?B?OVNvL2JUc04veWdMUlNTaUlpZmQ4V3JWM3hpQ1NIUFhNWHlzMytLOVpEMjhi?=
 =?utf-8?B?VEVSOXRiTm5rUU5MV1ppTFlKR2EvbW5kakhnWXdFekZsN3BraGkwaTUvYVMv?=
 =?utf-8?Q?FamQEQ=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ZTVNdDJFb1J2YTUvaEJKOWJ4RDMrVTRscHJPSHZkMUVKNlQ5c2pWNC9EZWFQ?=
 =?utf-8?B?N0dUS0g4V2NGR3EvWU9nVTN0NC9NeWtENHB2VktWZStPcE5zNjFjNGRCWlZ6?=
 =?utf-8?B?MzV3QjBOOG51N3NKZmhBRHM3NnNTazltZTlla0U5SmhVQUhnMjlpcFlsWVJt?=
 =?utf-8?B?b2k1TUZGdjRsZ1BkekpWc0tkMHRRSFhiaEI5TVhCcVJja2RxdHJtUDl4ZFJt?=
 =?utf-8?B?UjZEV01YZDZsc3dRU2FxTGJDWVE5TEFIeWZQOVgxRWpGSG9VNTNNbk5sVk85?=
 =?utf-8?B?UTAzdzlyUXZzYm8waUZ6Y2VFdzUxMlBGZWVXY2puaXM0MTYvSldyUTN1Tjl6?=
 =?utf-8?B?MmdRcTEvQm9ObUdjeHI3WUVqZFZuSTNIbDY0akF6US9GdnBOZVVHQjhWNVdD?=
 =?utf-8?B?MVpBRlBxOHFZNkx0UG1qalRUa3Z4dlJWSUNvblp0TzJsNEhEU0FMWmF5SXVm?=
 =?utf-8?B?OVJpaW8rVjZ0K0preWxWQWNRSXZuK0FOaDZWTnZOWVl1b1VSTUZHcGpOTFpC?=
 =?utf-8?B?Z3BwcDB2VjQzM2Fra1UyWFpZb29jWXMvNGhCeVFVakt4dzR6bDlvNE9ub2hs?=
 =?utf-8?B?aVFmeGdPWGg2aHNkZnZTL3h4aDZoUkEveERPZGhiUmFkcklRK1VtaGk5d3hB?=
 =?utf-8?B?aHdFZFRGdnE4dWRXZjdMY1RxWldUazczVThScXVDc2VxWmd5V0w0VzNCaFh1?=
 =?utf-8?B?Skg2aGdlRFh5TEpxazl5TlgzOCtrSTk4YURCQW9vQjhRRkZZUjR1Qkd4a0k1?=
 =?utf-8?B?eDJ1M0d5bjBBaXNaaTl5WEdxWjZuUkhIVEg5YW9LVC85aHMvUWdiSWxxc0hp?=
 =?utf-8?B?anZWYkd0cThtMUxkMU5GVFRDY0Vmcit0NllxdzdJVTdGdVM1aG9TWkVndXhh?=
 =?utf-8?B?dWRUd2xUUzZqcmg3OFJucE9TVit0YXUxZTd3TTAxNlQxMmM0U2lOK1lrWFo3?=
 =?utf-8?B?L3pTSkhDUzFuODRlVjBRZnVWTUZFNUZscGxKZno3SEptVy9GZ3dFNUoySlJk?=
 =?utf-8?B?RE9EYmFYU2N3VGFjTktYdEZTQ3JnQ3JUVWNwSHN3Nm1hN2sxWFA1TC9oV3di?=
 =?utf-8?B?TTVtUUttM05qUy9Rc0w2dWc0NmE0RlJBc29TNmRpOWRjcm5HRzJDWnZ6Q1Jq?=
 =?utf-8?B?eDZnOExGcS9IMVN1VWJyT3RVaThRVFNhNlpyWEpISGlsRVN5Y0ZjT0VybXZj?=
 =?utf-8?B?Q290R0tZWVhyeTkxTVFvVTlSRkllaXJJVXp0SUdhS0gzOGZOR3hXRkhwR2pa?=
 =?utf-8?B?UmRZU3YreG9mcE54ancvZkdWN3ptNm9xcWdOaFZnK3pCRFc0V1NWbS9sTlJF?=
 =?utf-8?B?eVhOUThocW1KZXcvcjBPZTRZM1pkVzhaUGRNQ0N1TkhiQXZTbkZWSHFPbHE1?=
 =?utf-8?B?VkpQM0dyWTl5NTBVWGhYaEhxWFBSdDFGeUg5TEJ2TW5kOUlDRU1qbldTNTMr?=
 =?utf-8?B?ZThIRzlXVFg0RGVoV05aSlpyZVhlcjJYdFVoYVhjdlljYWQzUytEaWRleXIv?=
 =?utf-8?B?eEozcndpc1FOSElGd29SWFdPdFVqcGNsMXpZdTlIU0JFNFJkT1FJK3pDcjVZ?=
 =?utf-8?B?eXorWEV1WTU2NlJCVTJVcndsYjJqNHFqakpSVElrQXlDMGdFUXRCbXp1ZjdI?=
 =?utf-8?Q?u4BKalg+RxRs4JpjhwhEvbgaOOxwFlDMjYmGfy+Yr7Ng=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: db48bf3a-c44d-444a-a455-08dd81025830
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Apr 2025 18:28:42.5866
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR02MB10028

RnJvbTogUGV0ZXIgWmlqbHN0cmEgPHBldGVyekBpbmZyYWRlYWQub3JnPiBTZW50OiBNb25kYXks
IEFwcmlsIDE0LCAyMDI1IDQ6MTIgQU0NCj4gDQo+IEluc3RlYWQgb2YgdXNpbmcgYW4gaW5kaXJl
Y3QgY2FsbCB0byB0aGUgaHlwZXJjYWxsIHBhZ2UsIHVzZSBhIGRpcmVjdA0KPiBjYWxsIGluc3Rl
YWQuIFRoaXMgYXZvaWRzIGFsbCBDRkkgcHJvYmxlbXMsIGluY2x1ZGluZyB0aGUgb25lIHdoZXJl
DQo+IHRoZSBoeXBlcmNhbGwgcGFnZSBkb2Vzbid0IGhhdmUgSUJUIG9uLg0KPiANCj4gU2lnbmVk
LW9mZi1ieTogUGV0ZXIgWmlqbHN0cmEgKEludGVsKSA8cGV0ZXJ6QGluZnJhZGVhZC5vcmc+DQo+
IC0tLQ0KPiAgYXJjaC94ODYvaHlwZXJ2L2h2X2luaXQuYyB8ICAgNjIgKysrKysrKysrKysrKysr
KysrKysrKystLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDMxIGlu
c2VydGlvbnMoKyksIDMxIGRlbGV0aW9ucygtKQ0KPiANCj4gLS0tIGEvYXJjaC94ODYvaHlwZXJ2
L2h2X2luaXQuYw0KPiArKysgYi9hcmNoL3g4Ni9oeXBlcnYvaHZfaW5pdC5jDQo+IEBAIC0zNywy
NCArMzcsNDIgQEANCj4gIHZvaWQgKmh2X2h5cGVyY2FsbF9wZzsNCj4gDQo+ICAjaWZkZWYgQ09O
RklHX1g4Nl82NA0KPiArc3RhdGljIHU2NCBfX2h2X2h5cGVyZmFpbCh1NjQgY29udHJvbCwgdTY0
IHBhcmFtMSwgdTY0IHBhcmFtMikNCj4gK3sNCj4gKwlyZXR1cm4gVTY0X01BWDsNCj4gK30NCj4g
Kw0KPiArREVGSU5FX1NUQVRJQ19DQUxMKF9faHZfaHlwZXJjYWxsLCBfX2h2X2h5cGVyZmFpbCk7
DQo+ICsNCj4gIHU2NCBodl9wZ19oeXBlcmNhbGwodTY0IGNvbnRyb2wsIHU2NCBwYXJhbTEsIHU2
NCBwYXJhbTIpDQo+ICB7DQo+ICAJdTY0IGh2X3N0YXR1czsNCj4gDQo+IC0JaWYgKCFodl9oeXBl
cmNhbGxfcGcpDQo+IC0JCXJldHVybiBVNjRfTUFYOw0KPiAtDQo+ICAJcmVnaXN0ZXIgdTY0IF9f
cjggYXNtKCJyOCIpID0gcGFyYW0yOw0KPiAtCWFzbSB2b2xhdGlsZSAoQ0FMTF9OT1NQRUMNCj4g
Kwlhc20gdm9sYXRpbGUgKCJjYWxsICIgU1RBVElDX0NBTExfVFJBTVBfU1RSKF9faHZfaHlwZXJj
YWxsKQ0KPiAgCQkgICAgICA6ICI9YSIgKGh2X3N0YXR1cyksIEFTTV9DQUxMX0NPTlNUUkFJTlQs
DQo+ICAJCSAgICAgICAgIitjIiAoY29udHJvbCksICIrZCIgKHBhcmFtMSkNCj4gLQkJICAgICAg
OiAiciIgKF9fcjgpLA0KPiAtCQkgICAgICAgIFRIVU5LX1RBUkdFVChodl9oeXBlcmNhbGxfcGcp
DQo+ICsJCSAgICAgIDogInIiIChfX3I4KQ0KPiAgCQkgICAgICA6ICJjYyIsICJtZW1vcnkiLCAi
cjkiLCAicjEwIiwgInIxMSIpOw0KPiANCj4gIAlyZXR1cm4gaHZfc3RhdHVzOw0KPiAgfQ0KPiAr
DQo+ICt0eXBlZGVmIHU2NCAoKmh2X2h5cGVyY2FsbF9mKSh1NjQgY29udHJvbCwgdTY0IHBhcmFt
MSwgdTY0IHBhcmFtMik7DQo+ICsNCj4gK3N0YXRpYyBpbmxpbmUgdm9pZCBodl9zZXRfaHlwZXJj
YWxsX3BnKHZvaWQgKnB0cikNCj4gK3sNCj4gKwlodl9oeXBlcmNhbGxfcGcgPSBwdHI7DQo+ICsN
Cj4gKwlpZiAoIXB0cikNCj4gKwkJcHRyID0gJl9faHZfaHlwZXJmYWlsOw0KPiArCXN0YXRpY19j
YWxsX3VwZGF0ZShfX2h2X2h5cGVyY2FsbCwgKGh2X2h5cGVyY2FsbF9mKXB0cik7DQo+ICt9DQo+
ICAjZWxzZQ0KPiArc3RhdGljIGlubGluZSB2b2lkIGh2X3NldF9oeXBlcmNhbGxfcGcodm9pZCAq
cHRyKQ0KPiArew0KPiArCWh2X2h5cGVyY2FsbF9wZyA9IHB0cjsNCj4gK30NCj4gIEVYUE9SVF9T
WU1CT0xfR1BMKGh2X2h5cGVyY2FsbF9wZyk7DQo+ICAjZW5kaWYNCj4gDQo+IEBAIC0zNDksNyAr
MzY3LDcgQEAgc3RhdGljIGludCBodl9zdXNwZW5kKHZvaWQpDQo+ICAJICogcG9pbnRlciBpcyBy
ZXN0b3JlZCBvbiByZXN1bWUuDQo+ICAJICovDQo+ICAJaHZfaHlwZXJjYWxsX3BnX3NhdmVkID0g
aHZfaHlwZXJjYWxsX3BnOw0KPiAtCWh2X2h5cGVyY2FsbF9wZyA9IE5VTEw7DQo+ICsJaHZfc2V0
X2h5cGVyY2FsbF9wZyhOVUxMKTsNCj4gDQo+ICAJLyogRGlzYWJsZSB0aGUgaHlwZXJjYWxsIHBh
Z2UgaW4gdGhlIGh5cGVydmlzb3IgKi8NCj4gIAlyZG1zcmwoSFZfWDY0X01TUl9IWVBFUkNBTEws
IGh5cGVyY2FsbF9tc3IuYXNfdWludDY0KTsNCj4gQEAgLTM3NSw3ICszOTMsNyBAQCBzdGF0aWMg
dm9pZCBodl9yZXN1bWUodm9pZCkNCj4gIAkJdm1hbGxvY190b19wZm4oaHZfaHlwZXJjYWxsX3Bn
X3NhdmVkKTsNCj4gIAl3cm1zcmwoSFZfWDY0X01TUl9IWVBFUkNBTEwsIGh5cGVyY2FsbF9tc3Iu
YXNfdWludDY0KTsNCj4gDQo+IC0JaHZfaHlwZXJjYWxsX3BnID0gaHZfaHlwZXJjYWxsX3BnX3Nh
dmVkOw0KPiArCWh2X3NldF9oeXBlcmNhbGxfcGcoaHZfaHlwZXJjYWxsX3BnX3NhdmVkKTsNCj4g
IAlodl9oeXBlcmNhbGxfcGdfc2F2ZWQgPSBOVUxMOw0KPiANCj4gIAkvKg0KPiBAQCAtNTI5LDgg
KzU0Nyw4IEBAIHZvaWQgX19pbml0IGh5cGVydl9pbml0KHZvaWQpDQo+ICAJaWYgKGh2X2lzb2xh
dGlvbl90eXBlX3RkeCgpICYmICFtc19oeXBlcnYucGFyYXZpc29yX3ByZXNlbnQpDQo+ICAJCWdv
dG8gc2tpcF9oeXBlcmNhbGxfcGdfaW5pdDsNCj4gDQo+IC0JaHZfaHlwZXJjYWxsX3BnID0gX192
bWFsbG9jX25vZGVfcmFuZ2UoUEFHRV9TSVpFLCAxLCBWTUFMTE9DX1NUQVJULA0KPiAtCQkJVk1B
TExPQ19FTkQsIEdGUF9LRVJORUwsIFBBR0VfS0VSTkVMX1JPWCwNCj4gKwlodl9oeXBlcmNhbGxf
cGcgPSBfX3ZtYWxsb2Nfbm9kZV9yYW5nZShQQUdFX1NJWkUsIDEsIE1PRFVMRVNfVkFERFIsDQo+
ICsJCQlNT0RVTEVTX0VORCwgR0ZQX0tFUk5FTCwgUEFHRV9LRVJORUxfUk9YLA0KPiAgCQkJVk1f
RkxVU0hfUkVTRVRfUEVSTVMsIE5VTUFfTk9fTk9ERSwNCj4gIAkJCV9fYnVpbHRpbl9yZXR1cm5f
YWRkcmVzcygwKSk7DQo+ICAJaWYgKGh2X2h5cGVyY2FsbF9wZyA9PSBOVUxMKQ0KPiBAQCAtNTY4
LDI3ICs1ODYsOSBAQCB2b2lkIF9faW5pdCBoeXBlcnZfaW5pdCh2b2lkKQ0KPiAgCQl3cm1zcmwo
SFZfWDY0X01TUl9IWVBFUkNBTEwsIGh5cGVyY2FsbF9tc3IuYXNfdWludDY0KTsNCj4gIAl9DQo+
IA0KPiAtc2tpcF9oeXBlcmNhbGxfcGdfaW5pdDoNCj4gLQkvKg0KPiAtCSAqIFNvbWUgdmVyc2lv
bnMgb2YgSHlwZXItViB0aGF0IHByb3ZpZGUgSUJUIGluIGd1ZXN0IFZNcyBoYXZlIGEgYnVnDQo+
IC0JICogaW4gdGhhdCB0aGVyZSdzIG5vIEVOREJSNjQgaW5zdHJ1Y3Rpb24gYXQgdGhlIGVudHJ5
IHRvIHRoZQ0KPiAtCSAqIGh5cGVyY2FsbCBwYWdlLiBCZWNhdXNlIGh5cGVyY2FsbHMgYXJlIGlu
dm9rZWQgdmlhIGFuIGluZGlyZWN0IGNhbGwNCj4gLQkgKiB0byB0aGUgaHlwZXJjYWxsIHBhZ2Us
IGFsbCBoeXBlcmNhbGwgYXR0ZW1wdHMgZmFpbCB3aGVuIElCVCBpcw0KPiAtCSAqIGVuYWJsZWQs
IGFuZCBMaW51eCBwYW5pY3MuIEZvciBzdWNoIGJ1Z2d5IHZlcnNpb25zLCBkaXNhYmxlIElCVC4N
Cj4gLQkgKg0KPiAtCSAqIEZpeGVkIHZlcnNpb25zIG9mIEh5cGVyLVYgYWx3YXlzIHByb3ZpZGUg
RU5EQlI2NCBvbiB0aGUgaHlwZXJjYWxsDQo+IC0JICogcGFnZSwgc28gaWYgZnV0dXJlIExpbnV4
IGtlcm5lbCB2ZXJzaW9ucyBlbmFibGUgSUJUIGZvciAzMi1iaXQNCj4gLQkgKiBidWlsZHMsIGFk
ZGl0aW9uYWwgaHlwZXJjYWxsIHBhZ2UgaGFja2VyeSB3aWxsIGJlIHJlcXVpcmVkIGhlcmUNCj4g
LQkgKiB0byBwcm92aWRlIGFuIEVOREJSMzIuDQo+IC0JICovDQo+IC0jaWZkZWYgQ09ORklHX1g4
Nl9LRVJORUxfSUJUDQo+IC0JaWYgKGNwdV9mZWF0dXJlX2VuYWJsZWQoWDg2X0ZFQVRVUkVfSUJU
KSAmJg0KPiAtCSAgICAqKHUzMiAqKWh2X2h5cGVyY2FsbF9wZyAhPSBnZW5fZW5kYnIoKSkgew0K
PiAtCQlzZXR1cF9jbGVhcl9jcHVfY2FwKFg4Nl9GRUFUVVJFX0lCVCk7DQo+IC0JCXByX3dhcm4o
IkRpc2FibGluZyBJQlQgYmVjYXVzZSBvZiBIeXBlci1WIGJ1Z1xuIik7DQo+IC0JfQ0KPiAtI2Vu
ZGlmDQoNCldpdGggdGhpcyBwYXRjaCBzZXQsIGl0J3MgbmljZSB0byBzZWUgSUJUIHdvcmtpbmcg
aW4gYSBIeXBlci1WIGd1ZXN0IQ0KSSBoYWQgcHJldmlvdXNseSB0ZXN0ZWQgSUJUIHdpdGggc29t
ZSBoYWNrZXJ5IHRvIHRoZSBoeXBlcmNhbGwgcGFnZQ0KdG8gYWRkIHRoZSBtaXNzaW5nIEVOREJS
NjQsIGFuZCBkaWRuJ3Qgc2VlIGFueSBwcm9ibGVtcy4gU2FtZQ0KYWZ0ZXIgdGhlc2UgY2hhbmdl
cyAtLSBubyBjb21wbGFpbnRzIGZyb20gSUJULg0KDQo+ICsJaHZfc2V0X2h5cGVyY2FsbF9wZyho
dl9oeXBlcmNhbGxfcGcpOw0KPiANCj4gK3NraXBfaHlwZXJjYWxsX3BnX2luaXQ6DQo+ICAJLyoN
Cj4gIAkgKiBoeXBlcnZfaW5pdCgpIGlzIGNhbGxlZCBiZWZvcmUgTEFQSUMgaXMgaW5pdGlhbGl6
ZWQ6IHNlZQ0KPiAgCSAqIGFwaWNfaW50cl9tb2RlX2luaXQoKSAtPiB4ODZfcGxhdGZvcm0uYXBp
Y19wb3N0X2luaXQoKSBhbmQNCj4gQEAgLTY1OCw3ICs2NTgsNyBAQCB2b2lkIGh5cGVydl9jbGVh
bnVwKHZvaWQpDQo+ICAJICogbGV0IGh5cGVyY2FsbCBvcGVyYXRpb25zIGZhaWwgc2FmZWx5IHJh
dGhlciB0aGFuDQo+ICAJICogcGFuaWMgdGhlIGtlcm5lbCBmb3IgdXNpbmcgaW52YWxpZCBoeXBl
cmNhbGwgcGFnZQ0KPiAgCSAqLw0KPiAtCWh2X2h5cGVyY2FsbF9wZyA9IE5VTEw7DQo+ICsJaHZf
c2V0X2h5cGVyY2FsbF9wZyhOVUxMKTsNCg0KVGhpcyBjYXVzZXMgYSBoYW5nIGdldHRpbmcgaW50
byB0aGUga2R1bXAga2VybmVsIGFmdGVyIGEgcGFuaWMuDQpoeXBlcnZfY2xlYW51cCgpIGlzIGNh
bGxlZCBhZnRlciBuYXRpdmVfbWFjaGluZV9jcmFzaF9zaHV0ZG93bigpDQpoYXMgZG9uZSBjcmFz
aF9zbXBfc2VuZF9zdG9wKCkgb24gYWxsIHRoZSBvdGhlciBDUFVzLiBJIGRvbid0IGtub3cNCnRo
ZSBkZXRhaWxzIG9mIGhvdyBzdGF0aWNfY2FsbF91cGRhdGUoKSB3b3JrcywgYnV0IGl0J3MgZWFz
eSB0byBpbWFnaW5lIHRoYXQNCml0IHdvdWxkbid0IHdvcmsgd2hlbiB0aGUga2VybmVsIGlzIGlu
IHN1Y2ggYSBzdGF0ZS4NCg0KVGhlIG9yaWdpbmFsIGNvZGUgc2V0dGluZyBodl9oeXBlcmNhbGxf
cGcgdG8gTlVMTCBpcyBqdXN0IHRpZGluZXNzLg0KT3RoZXIgQ1BVcyBhcmUgc3RvcHBlZCBhbmQg
Y2FuJ3QgYmUgbWFraW5nIGh5cGVyY2FsbHMsIGFuZCB0aGlzIENQVQ0Kc2hvdWxkbid0IGJlIG1h
a2luZyBoeXBlcmNhbGxzIGVpdGhlciwgc28gc2V0dGluZyBpdCB0byBOVUxMIG1vcmUNCmNsZWFu
bHkgY2F0Y2hlcyBzb21lIGVycm9uZW91cyBoeXBlcmNhbGwgKHZzLiBhY2Nlc3NpbmcgdGhlIGh5
cGVyY2FsbA0KcGFnZSBhZnRlciBIeXBlci1WIGhhcyBiZWVuIHRvbGQgdG8gcmVzZXQgaXQpLg0K
DQpJZiBJIHJlbW92ZSB0aGlzIGNoYW5nZSBhbmQgbGV0IGh2X2h5cGVyY2FsbF9wZyBiZSBzZXQg
dG8gTlVMTCB3aXRob3V0DQpkb2luZyBzdGF0aWNfY2FsbF91cGRhdGUoKSwgdGhlbiB3ZSBjb3Jy
ZWN0bHkgZ2V0IHRvIHRoZSBrZHVtcCBrZXJuZWwNCmFuZCBldmVyeXRoaW5nIHdvcmtzLg0KDQpN
aWNoYWVsDQoNCj4gDQo+ICAJLyogUmVzZXQgdGhlIGh5cGVyY2FsbCBwYWdlICovDQo+ICAJaHlw
ZXJjYWxsX21zci5hc191aW50NjQgPSBodl9nZXRfbXNyKEhWX1g2NF9NU1JfSFlQRVJDQUxMKTsN
Cj4gDQo+IA0KDQo=

