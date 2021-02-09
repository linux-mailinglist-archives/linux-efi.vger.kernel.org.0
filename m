Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 233613153E9
	for <lists+linux-efi@lfdr.de>; Tue,  9 Feb 2021 17:32:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232918AbhBIQbe (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 9 Feb 2021 11:31:34 -0500
Received: from mail-eopbgr80082.outbound.protection.outlook.com ([40.107.8.82]:38046
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229683AbhBIQbV (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Tue, 9 Feb 2021 11:31:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fSfBeqQu2ZNAulHAwLik+ndn0PoLiO5JFqhZf2KazCM=;
 b=B3FKj3/YNGEYKB85uiOkJoz90SJZqmrFblL4qRDsDrVig91z7Qm4BnfwNh1+tmyE69xLBSmQYnVA3K+nHBohdzQVGg8+9n/hfw7Mb75XhJYAeVRzDMTv+aEi9iFQmMVh0DLPsAxScBVDj4S0Es7c99/3panL2J1g1eHgjdqb6Hw=
Received: from DB6PR07CA0009.eurprd07.prod.outlook.com (2603:10a6:6:2d::19) by
 AM0PR08MB3873.eurprd08.prod.outlook.com (2603:10a6:208:10c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.19; Tue, 9 Feb
 2021 16:30:32 +0000
Received: from DB5EUR03FT003.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:6:2d:cafe::ff) by DB6PR07CA0009.outlook.office365.com
 (2603:10a6:6:2d::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.11 via Frontend
 Transport; Tue, 9 Feb 2021 16:30:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=pass action=none
 header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 DB5EUR03FT003.mail.protection.outlook.com (10.152.20.157) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3784.11 via Frontend Transport; Tue, 9 Feb 2021 16:30:31 +0000
Received: ("Tessian outbound f362b81824dc:v71"); Tue, 09 Feb 2021 16:30:31 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 6f365614198d9450
X-CR-MTA-TID: 64aa7808
Received: from c83f8edfa328.3
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 78E4BF87-AB8D-40C0-A3E8-9D9640A82DAE.1;
        Tue, 09 Feb 2021 16:30:19 +0000
Received: from EUR03-AM5-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id c83f8edfa328.3
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Tue, 09 Feb 2021 16:30:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kcbVlXYMx2ywHFrCQ/ewl7ZDnOm4MhKFRD63rJ+AEgWOqQ3qKWKY2lkOCte7LsrBJaOr3idSBne0oyc/RFo7M8Dhs9bYRyGYiQLT7IL+eJeWMkvfJl4Hrtf9sHmTghk2KPyVGNAKvK0URkzdIBc2HNv7jMqg3b3UairIi7NjKD5ZYPZnIj7x/J3BKvuw6PDu1XM+H71wNApGSQ5ZJjB24gfBdLw3Jddrkd5M9Chq/EJnV8zMTnq1rp3jYj8VM9tKxq1HfmidFwOHGSm/4g7YYMRNdttoHDma4d5ptJR4eeLCvFpnneGJpof8XKEp+4jnKXxkVANPg9821jT9XBtoJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fSfBeqQu2ZNAulHAwLik+ndn0PoLiO5JFqhZf2KazCM=;
 b=GlcR0iWhpDTDx9Ql2SHySkV7dDpZ26FJ/FBAmXnfytB5TYVi9/XdGKjkVW5p3o0FfFtoab2nFhSOLbyuw6RUSzmYEY5b2KlPbiqVL8nmCzNmWgclaeK/QpXbEOPGskO0haNZ3DUR4YjhhP570FtWV2lCIAj4HTLPqFIANubVa9MslZE0L90Ubt3XO8pY2cN4P5FdIPeT4jVe1HYRBQu4vYGslEtWuyLPEn6RPPfrC9+loOI1/N46UajsNVMpm47/JeiwKDXQ9md6l7goeL5b3tULN6hmi+2xJ/DiIEGhHPgKQawC/Fn4Zig6k/1yzyDhumMnpSUNoPltKXPwNVUCJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fSfBeqQu2ZNAulHAwLik+ndn0PoLiO5JFqhZf2KazCM=;
 b=B3FKj3/YNGEYKB85uiOkJoz90SJZqmrFblL4qRDsDrVig91z7Qm4BnfwNh1+tmyE69xLBSmQYnVA3K+nHBohdzQVGg8+9n/hfw7Mb75XhJYAeVRzDMTv+aEi9iFQmMVh0DLPsAxScBVDj4S0Es7c99/3panL2J1g1eHgjdqb6Hw=
Received: from AM0PR08MB3026.eurprd08.prod.outlook.com (2603:10a6:208:65::21)
 by AM0PR08MB3795.eurprd08.prod.outlook.com (2603:10a6:208:105::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.30; Tue, 9 Feb
 2021 16:30:17 +0000
Received: from AM0PR08MB3026.eurprd08.prod.outlook.com
 ([fe80::c98b:a3ef:b40e:c8ae]) by AM0PR08MB3026.eurprd08.prod.outlook.com
 ([fe80::c98b:a3ef:b40e:c8ae%5]) with mapi id 15.20.3825.030; Tue, 9 Feb 2021
 16:30:17 +0000
From:   Daniel Kiss <Daniel.Kiss@arm.com>
To:     Nick Desaulniers <ndesaulniers@google.com>
CC:     Julien Thierry <jthierry@redhat.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Catalin Marinas <Catalin.Marinas@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        "linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Mark Rutland <Mark.Rutland@arm.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Peter Zijlstra <peterz@infradead.org>,
        =?utf-8?B?UmFwaGHDq2wgR2F1bHQ=?= <Raphael.Gault@arm.com>,
        Will Deacon <will@kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Bill Wendling <morbo@google.com>,
        "swine@google.com" <swine@google.com>,
        "yonghyun@google.com" <yonghyun@google.com>
Subject: Re: [RFC PATCH 12/17] gcc-plugins: objtool: Add plugin to detect
 switch table on arm64
Thread-Topic: [RFC PATCH 12/17] gcc-plugins: objtool: Add plugin to detect
 switch table on arm64
Thread-Index: AQHW+beH+WRA0XVWfUiytbrbk83nQapQDkIA
Date:   Tue, 9 Feb 2021 16:30:17 +0000
Message-ID: <2935D431-6329-4BC8-A871-A019CD3F6EB1@arm.com>
References: <20210120173800.1660730-13-jthierry@redhat.com>
 <20210127221557.1119744-1-ndesaulniers@google.com>
 <20210127232651.rj3mo7c2oqh4ytsr@treble>
 <CAKwvOdkOeENcM5X7X926sv2Xmtko=_nOPeKZ2+51s13CW1QAjw@mail.gmail.com>
 <20210201214423.dhsma73k7ccscovm@treble>
 <CAKwvOdmgNPSpY2oPHFr8EKGXYJbm7K9gySKFgyn4FERa9nTXmw@mail.gmail.com>
 <671f1aa9-975e-1bda-6768-259adbdc24c8@redhat.com>
 <CAKwvOdkqWyDbAvMJAd6gkc2QAEL7DiZg6_uRJ6NUE4tCip4Jvw@mail.gmail.com>
In-Reply-To: <CAKwvOdkqWyDbAvMJAd6gkc2QAEL7DiZg6_uRJ6NUE4tCip4Jvw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.60.0.2.21)
Authentication-Results-Original: google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=none action=none header.from=arm.com;
x-originating-ip: [2001:4c4c:1b2a:1000:9c7d:1b80:7ac6:94b6]
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: cf029f23-1654-48e8-ac9e-08d8cd1804f2
x-ms-traffictypediagnostic: AM0PR08MB3795:|AM0PR08MB3873:
x-ms-exchange-transport-forked: True
X-Microsoft-Antispam-PRVS: <AM0PR08MB38734D6A8EE486987ECFE9ADEC8E9@AM0PR08MB3873.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
nodisclaimer: true
x-ms-oob-tlc-oobclassifiers: OLM:9508;OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: KSsJp56/A4cDBuS0hoJ+xPSdfNYeVF5VsxYU1JPTxBqNHKFTELfasLjBKzPrHu1GZFDw1caEV0iRL2faabd/wHErHmvCAfYaGowD1VXbbfR0RV6gzoQuPuI/83n5qCA8ZzbamK0WEVo1VQosesmgTP4S8EBwqWb1YM4xPo9d7lF2IHWThy02ln6PsyoT06yBnfGNu71kAR4mgS4PY848Ng8MLoYipl75umEua/Pg56bZe2cOD9uplKK/jWAdoZW33lmUY1q2TGSB9wrDfgSgqSQ2pwoVW4988/Hyb7HW/97FiKSDW/J/QN03bf0eWIxXEKQuT/cIo0LUAyHdk8dBJ+lkDvklnzrZckgIMB5+F+TE3M1fpjLekEmhnXvZhsJ2Flhe6eIt7ThCue8sRnzstczyK/uD0KLskhDWvuEak0ebmTyvZMClrECuO0MGNQs1wH0rQOfS2n3oh5scMuhiB/UzG5M+aDkMnwWCX3mHypSNIVVh4nsY8nFsH5b3SkiAoS9HyiBQlPaIK2K3faPnqdvzCuREuUkbxQ9+fVJQ8pU//BoHsglGUGKgJDpC4LZ379Mdh/mGnnV0NzJXHc294A==
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR08MB3026.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(136003)(346002)(39860400002)(396003)(366004)(4744005)(83380400001)(5660300002)(54906003)(71200400001)(478600001)(36756003)(33656002)(316002)(8676002)(66556008)(7416002)(86362001)(66946007)(66446008)(64756008)(2906002)(2616005)(91956017)(76116006)(8936002)(6486002)(66476007)(6916009)(6512007)(186003)(4326008)(53546011)(6506007)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?SFJPVWdwdlBLcVZ2YkRianA4ZXptZHIyOVJkQk9FUWUza09Vdm5BUnd4Rksz?=
 =?utf-8?B?aUVEUjVOM0xwMi80NWxteFc4dTJPSHZLNnZmK2RXak1zbnRBeFpzMzMvbVM1?=
 =?utf-8?B?QzFlWUgva2VxQU1ZbGtxSWxrYjQxVDlmdUpSL0dJSGZIeERNZEJGeDlXYVda?=
 =?utf-8?B?bTZuT1ZlTFdEWWZnL3lqamU4N0lwZTE1ekZmNzNZOGVXUytWWk80aVpndzRo?=
 =?utf-8?B?clNEUjFkWGcxeFk3MngxanVBa3AydHh4UzBJNGNsc2o5MFQxYnkxV2FCRW5p?=
 =?utf-8?B?RHpSV09UaS9peVR5QTBIUGVvUi8vaGZua3E2cTBXQ3dxbXcvQ0N1MWQzVzBk?=
 =?utf-8?B?dEU0eGFoc2l3V2VjdHdrZXBMRWJ6R2VhR3ZyaVl6a3Q3dlpGWEpjT210Nkgy?=
 =?utf-8?B?UllST0t0amxoQ2dObXdFNmRra1FvUlhBVnkxMWppM1RmWVpjeFRMc0d6a1pY?=
 =?utf-8?B?clRrcTI0bEVuYkN2UFNRWUZodEJzdzdnYUttYzVPNVRnUitOcG1IK3d5UlhJ?=
 =?utf-8?B?Y0R0bmFEL0NhTnFRQkQ1QnJrTGJNbGpiVTRpWGlsMk1kSjNEbjVQTXZaNmNE?=
 =?utf-8?B?ZGdZT1ZaU21zalZVVDFaNnc4TmZCa2U4MDZCdGpXaVd6MUJmUXhnTVdVbHlY?=
 =?utf-8?B?UnVhanBjcjhJNWJWckpKYUF3OHNsdG5OcjZ5dSs0NkJaQ0NZNFpNa2NWNUY4?=
 =?utf-8?B?R3BiL0t5SEJ6RFhFeGVIL1RRclFTQnJBYmVaYUtiR2txbjFNTWMyQ0g1cS9O?=
 =?utf-8?B?NnBBN2dsRXo2Y3JZNTlscFhlVHFWWXJqMVk3ZXdmdG1Ud25xaW5uOUtjOHJ4?=
 =?utf-8?B?QXRlVFVubWUvcWNYUWx3ZEF0MUZIMWd5LzB1Z2NQZE1jalF2WGM4V2RNU3lv?=
 =?utf-8?B?blNIQVg3eWlhRktwYUY3dDF2Nlp6MlZpZEFHUENUM0IwVWZlSG5oSVJocGZx?=
 =?utf-8?B?NXdNQVlQVVpHdnRiMDJTZml0cmFPOUNSdzRGQm12TUdBcUJsRTVsRlpDQkw0?=
 =?utf-8?B?d0dUcDd2YzhtcitxWFZpdllMSytvYW1tUlM2ZEJ5U1h4TjYrQ0xPSlFmQmkr?=
 =?utf-8?B?QUV5S0N2ZnAyTTdNR1d3ZHM4MkxFa292Vkk4NVZQanM0dHAxbW50YkwwQ1Z6?=
 =?utf-8?B?eWFRZHZWR0dXdDdKZjk2ODRvMVJTcktDVlNBbVJ5dVhRTXNDSXlVRWhtZHV4?=
 =?utf-8?B?aDc0aHpUbEFJbGIrSmMrcFBpMHA1SEgrcWQyTk53TFQ2Y2ExVHlIQytPLzlB?=
 =?utf-8?B?ZUczRU0yRG15WDJVR0FML2FSbmVLR056SlRwSG5SN0dDL1VMakY1djBWOGF4?=
 =?utf-8?B?NS81RjVocGdROVJSVmYvSlVVUDExemwvb01nUnNpS0dFZzNXdTdHQ1BYNWxl?=
 =?utf-8?B?YUJ5amNjazJIeUdvR2laNnhFQ1oxQk9BOGFWWVNhYkJvQVBEUXZla1JzZXFp?=
 =?utf-8?B?cGpOeWpOWHdpdjFmV05DMXU4ZzNJME10dFAwVnJqcTVFSEtBcWl4SEsrVHJS?=
 =?utf-8?B?Z3dVS2dTYjh6R0dXQTdnS1FBSEQzS3gwSTBVdUwxQm40cnYydG52L2l4RzlQ?=
 =?utf-8?B?akk2b0wvdTFiV2pwZVlaWUNSNUl5WEViUnhmMzRwdjdKQzdLTkNmb1draHhF?=
 =?utf-8?B?T2Q4dnRkbit5OU5PMVVzaFdRYUI3WkVpS0NWbjY1T2gremFXMllJYndoL3Ri?=
 =?utf-8?B?OUxyTTNmRDkwcjlIUDcrbXg1UUJSbmdXaVlybk9uZTFGb0NGNllRNmJsZDc1?=
 =?utf-8?B?V25UTGdwVjROYll2UDFMbVlqUGsxR3pLbHBiM21sV21xUDhPakxxQTVTeU4y?=
 =?utf-8?B?cGcxeVZGNFc2L0h0ZzVKNXBPQ3FTak5adzdhS1JoSTRqUEhCOTducE5XbGdJ?=
 =?utf-8?B?S29DZFVKVWlZSDROYUdBYWJHalNIcXNUVWdyY2E5MXlxL3c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <89F0BA4422638D468205ED064961D3CD@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB3795
Original-Authentication-Results: google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB5EUR03FT003.eop-EUR03.prod.protection.outlook.com
X-MS-Office365-Filtering-Correlation-Id-Prvs: 98d97d2d-8fd6-4aa8-3482-08d8cd17fc5d
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /T43Oe78eReW81Tp+jhYeUirNGdWjGGGQMBA7et6pSZxKhfr/jza/T8+6kq3mcdNTeDPduT97sc9EpbbacI4xfafFs2R9SfA9kMnrCIr6XtD6JZfH2d0xRJ8fP8GJSeHKslBQyiYkEZCTT7qISLdQ8z91J2sm8NevaLjZXaAgTakw9gwuvQiembO0FLSNL4U+s16U/Z8zR74mbWB34laTyXYzYwxXCYxWvGFkoveVVU07lviI92DpMH0DkRHv0e5KLoJk1p+0ddOnptPnlLJD0DqOXFUQuKoY5v88VuDzamo55ganTgAXEjIREoHsqLkos5Xmmr/k6d/h+RGWPz8VqP4mZZmuPJW7HLblE0VjnUU/PwsqPOdS17wNXwBHlMyalbFJQWbzQbE1CAMhKJ+ukvtOGGXjQg34ivKHXgeko/6dbZ7LtTy5lSFCIgkpsjbMrN+sm+PQJxTmpTDU/7eiZALkcVqj4zDvcjSjeqgN6Oy4MzxCf4eGh2gYUJWN41uOapzXxJUY8hn+/QSBiVGJVpkiBGljq+qyzrNqINb8XRF1ZzhgLvJB8qgc9A9ivdfLzb4ffdYDMf+la0f2DS+zrlojChVDdrHrnZPZrLBl8bh3K8FZYLg5UhLa2KBnpwUO5gYuP9PZ39d3Efj8QSDJA==
X-Forefront-Antispam-Report: CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(4636009)(136003)(39860400002)(396003)(376002)(346002)(36840700001)(46966006)(83380400001)(26005)(6512007)(82740400003)(82310400003)(356005)(4744005)(8936002)(2906002)(6506007)(6486002)(6862004)(4326008)(53546011)(478600001)(36756003)(450100002)(81166007)(36860700001)(86362001)(5660300002)(47076005)(107886003)(70586007)(70206006)(186003)(316002)(54906003)(2616005)(33656002)(336012)(8676002);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2021 16:30:31.8727
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cf029f23-1654-48e8-ac9e-08d8cd1804f2
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: DB5EUR03FT003.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB3873
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

DQoNCj4gT24gMyBGZWIgMjAyMSwgYXQgMDA6MDEsIE5pY2sgRGVzYXVsbmllcnMgPG5kZXNhdWxu
aWVyc0Bnb29nbGUuY29tPiB3cm90ZToNCj4gDQo+IEkgd29uZGVyIGlmIFBBQyBvciBCVEkgYWxz
byBtYWtlIHRoaXMgc2xpZ2h0bHkgbW9yZSBjb21wbGV4PyAgUEFDIGF0DQo+IGxlYXN0IGhhcyBp
bXBsaWNhdGlvbnMgZm9yIHVud2luZGVycywgSUlVQy4NCg0KQlRJIGhhcyBlZmZlY3Qgb24gdGhl
IGp1bXAgdGFyZ2V0XGNhc2UgYmVjYXVzZSBhIGxhbmRpbmcgcGFkIGlzIHJlcXVpcmVkIGZvciBl
YWNoIGFuZCBldmVyeSB0YXJnZXQuDQpBcyBJIHNlZSB0aGF0IHdvdWxkIG5vdCBodXJ0IGhlcmUu
DQoNClRoZSB1bndpbmRlciBzaGFsbCB0YWtlIGNhcmUgb2YgdGhlIFBBQyBzaWduZWQgcmV0dXJu
IGFkZHJlc3MgaWYgcmVhZHMgdGhlIExSIGZyb20gdGhlIHN0YWNrLg0KRFdBUkYgY29udGFpbnMg
YW4gZW50cnkgd2hlcmUgdGhlIExSIGlzIGdvdCBzaWduZWRcYXV0aGVudGljYXRlZC4NCg0KSeKA
mW0gd29uZGVyaW5nIHdvdWxkIGJlIHNpbXBsZXIgb3IgcG9zc2libGUgdG8gdHJhbnNmb3JtIHRo
ZSBEV0FSRCB0byBPUkMuDQoNCg==
