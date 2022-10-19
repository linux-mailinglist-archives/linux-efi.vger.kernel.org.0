Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A12AF603AE4
	for <lists+linux-efi@lfdr.de>; Wed, 19 Oct 2022 09:45:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230097AbiJSHpo (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 19 Oct 2022 03:45:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229915AbiJSHpm (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 19 Oct 2022 03:45:42 -0400
X-Greylist: delayed 66 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 19 Oct 2022 00:45:41 PDT
Received: from esa5.hc3370-68.iphmx.com (esa5.hc3370-68.iphmx.com [216.71.155.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91B0641D14;
        Wed, 19 Oct 2022 00:45:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=citrix.com; s=securemail; t=1666165541;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=nCjepG4+x3G8akI34ML5FMuWbzs7JABKYKV0qvvHwtE=;
  b=U3BxnQPpNeOX2Bjshv92+4M4VyZnUlOJjWF9Y188bZmbX93eeqcKZpuZ
   r3y2kBq6XuXqb471CEyg2flAv24zCy1HG9OMyhUCHldT3WB+0x1Q8/GY0
   BPz4aVZ81S+f9xrHj9fk1co6OmaJckgiV7mxJrPNIQFc7z1isA05x6GgP
   4=;
X-IronPort-RemoteIP: 104.47.73.42
X-IronPort-MID: 82156819
X-IronPort-Reputation: None
X-IronPort-Listener: OutboundMail
X-IronPort-SenderGroup: RELAY_O365
X-IronPort-MailFlowPolicy: $RELAYED
IronPort-Data: A9a23:tYNaTKMzDUpj+PvvrR29l8FynXyQoLVcMsEvi/4bfWQNrUp00zACz
 GodCmGCPfneamH1fN0ibdm19U9QuMeDmIAySQto+SlhQUwRpJueD7x1DKtS0wC6dZSfER09v
 63yTvGacajYm1eF/k/F3oDJ9CU6j+fQLlbFILasEjhrQgN5QzsWhxtmmuoo6qZlmtH8CA6W0
 T/Ii5S31GSNhnglbwr414rZ8Ek15ayr6WtB1rADTasjUGH2xiF94K03fcldH1OgKqFIE+izQ
 fr0zb3R1gs1KD90V7tJOp6iGqE7aua60Tqm0xK6aID76vR2nQQg075TCRYpQRw/ZwNlPTxG4
 I4lWZSYEW/FN0BX8QgXe0Ew/ypWZcWq9FJbSJQWXAP6I0DuKhPRL/tS4E4eYp1C3cpbHzx37
 vUKBAwcbD66gqGaz+fuIgVsrpxLwMjDGqo64i0l4RSHSPEsTNbEXrnA4sJe0HEonMdSEP3CZ
 s0fLz1ycBDHZB4JMVASYH48tL7w2j+jLHsH8xTJ/8Lb4ECKpOB1+JHrPMDYZZqhQsJNk1zDj
 mnH4374ElcRM9n3JT+toij127GfxHKTtIQ6CbCezs5gpFCoyVM+LTsMbHu4scSloxvrMz5YA
 wlOksY0loA4/VeoScfVXgagunef+AQBM/JZCeEwwAKA0KzZ50CeHGdsZjRZQNUitcIwFXom2
 zehm871AhRsvaeTRHbb8a2bxRu+MDYYa28LYzQJSyMB4t/+sMcyiA7CSpBoF6vdptj0Hz736
 yqHoCg3m/MYistj/7224V3dkRqtoJbTRwI47wmRWXiqhitla4q1T4ip70XH9/FGLZbfQlTpl
 HsEnNKZ9+APCZaTvC2WWP8EB/ez+p6tNCPXxEZ1GJss/CiF/3+lYJBM7SpiJUFmdMEedlfBc
 B+NkQBc/pleOD2td6AfS4awDdk6iKXuFPz7Wf3OKNlDeJ58cEmA5i4GTUqR2X391Ushi6cyP
 b+Ffsu2S3UXE6JqyHyxXeh1+bsqwD0ugGPaX5z2yRWh3pKAa3OPD7QIKl2DaqY+9qzsnenO2
 9NWNs/PxxABVuT7OnXT6dRLcQpMKmUnD5frrcARbvSEPgdtBGAmDbnW3K8lfItm2a9Sk48k4
 02AZ6OR83Kn7VWvFOlAQikLhG/HNXqnkU8GAA==
IronPort-HdrOrdr: A9a23:+dDMHqB037nLJyvlHegPsceALOsnbusQ8zAXPh9KJCC9I/bzqy
 nxpp8mPEfP+U0ssHFJo6HiBEEZKUmsuKKdkrNhR4tKOzOW9FdATbsSp7cKpgeNJ8SQzJ876U
 4NSclD4ZjLfCBHZKXBkUaF+rQbsb+6GcmT7I+woUuFDzsaEp2IhD0JaDpzZ3cGIDWucqBJca
 Z0iPAmmxOQPVAsKuirDHgMWObO4/fRkoj9XBIADxk7rCGTkDKB8tfBYlml9yZbdwkK7aYp8G
 DDnQC8zL6kqeuHxhjV0HKWx4hKmeHm1sBICKW3+4gow3TX+0WVjbZaKvi/VQMO0aWSAZER4Z
 7xSiIbToZOArXqDyeISFXWqlDdOX0VmgLfIBej8AfeSIrCNXwH4oN69PxkmlGy0TtegPhslK
 1MxG6XrJxREFfJmzn8/cHBU1VwmlOzumdKq59bs5Vza/poVFZql/1owGpFVJMbWC7q4oEuF+
 djSMna+fZNaFufK3TUpHNmztCgVmk6Wk7ueDlIhuWFlzxN2HxpxUoRw8IS2n8G6ZImUpFBo+
 DJKL5hmr1CRtIfKah9GOACS82qDXGle2OFDEuCZVD8UK0XMXPErJD6pL0z+eGxYZQNiIA/nZ
 zQOWkowVLau3iefPFm8Kc7gSwlGl/NLAgF4vsul6RRq/n7WKfhNzGFRRQnj9agys9vcPHmZw
 ==
X-IronPort-AV: E=Sophos;i="5.95,195,1661832000"; 
   d="scan'208";a="82156819"
Received: from mail-dm6nam04lp2042.outbound.protection.outlook.com (HELO NAM04-DM6-obe.outbound.protection.outlook.com) ([104.47.73.42])
  by ob1.hc3370-68.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 19 Oct 2022 03:44:34 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EpzcQ7bzMiDRYHXEycjJX6YS0KmedV5iZLGc5jlv6+Lgv3cS+CZMMiG20sJQwhhkefv7uWXxY8nhBhgjckG9fUtB2jXMhUR7cyr6eAL9Hc0xDfI72ZxZywN7jdJ/NF8x4rZzYh8d9YLA4k4aQTZfiWJ0v2NbrNSuIw6ZemItL2qSv4aPC8cVwW2ntAc2QX9+r2IULXK0eHmCueJ/XvCgEPEkn6iETdeYYECMTyaTi2xTBwSa7Aa4lfWMwGc6KZtPzC3wYtU60worxvOZ5dPBsk3XO3U77U49pOYSs4HPg4in7bm9l+nYFR5+bOSigovwTtwC2FuJfk539dcu6BCf7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nCjepG4+x3G8akI34ML5FMuWbzs7JABKYKV0qvvHwtE=;
 b=Q5x49Bnk62dDdaN+ZW8SanSkIZaEWeKxeT7aQSDW05yTpxjjr1mEl5SZ0R2sS+W1oegHIiT4DAw5fH+EHsNQETfFC7ZXL5tPAxcmHWUMcbLVCTMvejIH3CqVVqbmGbNSKwlITYm2a1wBeeYh864mN/rD3xcViBb/mmnNJbs0Rw8WIkuU60Rdowcy20keCuc7v3qj1dp5JJ8JL69IxH38KdN0REei0yLobHMSsckAOA5Bx6VIUH4RffnCL4BVYTkojp+PuyFoNqQ3stt+TLGdjYYJETO8zbBUPIhKxmL1/fqY3T5Fcu0yLYic3G4lWDvObWnbJvlO1I5utj8uCRMuMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=citrix.com; dmarc=pass action=none header.from=citrix.com;
 dkim=pass header.d=citrix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=citrix.onmicrosoft.com; s=selector2-citrix-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nCjepG4+x3G8akI34ML5FMuWbzs7JABKYKV0qvvHwtE=;
 b=xMnTp3TdMRZqltyEz/mW6xKRUOvH6rLBJa/2wGzvGQkqr2/o64vKV4K0QclaZs3esg7AfSCPSmSpE1aKnhr/U5Bxh6JQZiBSN2jVXNM2GqJNgak2qUpPee0B+7O4xCFwrA0BKO8utNB+juZiNZBTn+WafVAar2a50lZVn1vM1OE=
Received: from BYAPR03MB3623.namprd03.prod.outlook.com (2603:10b6:a02:aa::12)
 by DS7PR03MB5399.namprd03.prod.outlook.com (2603:10b6:5:2cb::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.34; Wed, 19 Oct
 2022 07:44:33 +0000
Received: from BYAPR03MB3623.namprd03.prod.outlook.com
 ([fe80::1328:69bd:efac:4d44]) by BYAPR03MB3623.namprd03.prod.outlook.com
 ([fe80::1328:69bd:efac:4d44%3]) with mapi id 15.20.5723.034; Wed, 19 Oct 2022
 07:44:32 +0000
From:   Andrew Cooper <Andrew.Cooper3@citrix.com>
To:     Evgeniy Baskov <baskov@ispras.ru>, Ard Biesheuvel <ardb@kernel.org>
CC:     Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Alexey Khoroshilov <khoroshilov@ispras.ru>,
        "lvc-project@linuxtesting.org" <lvc-project@linuxtesting.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>,
        Andrew Cooper <Andrew.Cooper3@citrix.com>
Subject: Re: [PATCH 03/16] x86/boot: Set cr0 to known state in trampoline
Thread-Topic: [PATCH 03/16] x86/boot: Set cr0 to known state in trampoline
Thread-Index: AQHY41CLuknMGoQagUCToPct72zmNa4VVp8A
Date:   Wed, 19 Oct 2022 07:44:32 +0000
Message-ID: <7dce2b16-c652-8b6d-5594-d110c8ac4645@citrix.com>
References: <cover.1662459668.git.baskov@ispras.ru>
 <a155c20eec6343d34b3bdf40c024ce8b35a90e02.1662459668.git.baskov@ispras.ru>
In-Reply-To: <a155c20eec6343d34b3bdf40c024ce8b35a90e02.1662459668.git.baskov@ispras.ru>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=citrix.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR03MB3623:EE_|DS7PR03MB5399:EE_
x-ms-office365-filtering-correlation-id: 611930d9-ea72-49a3-0459-08dab1a5c313
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tM+NqFAjjSR581a/kuhYB3IJ12mRSWVW5vjwKhZ1r+dUzPdXrNfWN/obCPuNz89KEZNgWJTvRLGMBnaJjdCZoeQwxX0dfdVhMuoh4lCoX7KxCHyFKto9NpkLIL7D/BN2DBmqyc3dic0kNrHZsVUqIFS8O3ZwPABr6mcg76Gf4dqxuBqkdyVJRHE0tn+CGyHYOVALM8alltzpbnuFq3PzBXAfPhKKmuAztI1uIYVqwiPEB1g4aTCDNaB4y/vKDMbJ953gM11Z3IvwW/3M/P2S20kXP+lEqSbQhqnvjusQTSSaKnai8kqobILhHErb4HhURIZO+Ry02riiR820its2ot79vZ6FtkrBIRjBAq2p3vGpjupOD4Rw2jDzWwK3tvizzCVbsgThXaUQDLAQH4mJBstVK7QkDyvsjxjVP0nWeKrTx3ky9J9wjdB3nn8zNu0RigbChVISuuTayEyg71+0Immag2iAXmMdWr9SB3zKM2qgCT7fE1QofFJSwGb8MU+e1lAOd/dsO6G/RKePTns66d5FHlITJW1zmIvcjDCrDuZbEVOFoTIuSnDrcJxN55nvDk/fr4MTvM14MGbkLWvpKsBm6Spo78mDp/H9yvCrlF4uZtsFQaobr+CbmM1id9gS5hUyKLhBnnLDxNvAYV6vJzq78Ol9wPsluusZ70J5S+8m3XBEh32+s79slWfAEm8NlRV5ZopAypGaCk+mju5Um5iWGtYvqgtbYnfgwoLGxIw1lnR9UdoRVTF7iQtAFGnWrn+vKOLUuKzli1is6066qt2qBfTGgBfnK3lWEi2IFyOrRpss9A+KTBUzogvpylf1GHqJmd7GaDIbqCCyDO1T3A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR03MB3623.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(366004)(376002)(136003)(396003)(39860400002)(451199015)(36756003)(31686004)(71200400001)(478600001)(6486002)(83380400001)(122000001)(107886003)(86362001)(38100700002)(82960400001)(38070700005)(110136005)(2906002)(54906003)(186003)(316002)(2616005)(4744005)(7416002)(8936002)(41300700001)(6512007)(31696002)(5660300002)(8676002)(4326008)(6506007)(53546011)(76116006)(66476007)(91956017)(26005)(66556008)(66446008)(64756008)(66946007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZTE0MGtXRmI4cEdJUmJuRjB5blRvQmRlUWtDcWtjVWJ1SEt5b2tvam95WGVn?=
 =?utf-8?B?elE5NGtLb2xocENMYjc1dTAzUjV4dXZWYTlWQk53dTlqbGlUVk1CMWdqTE9u?=
 =?utf-8?B?eEJWZHZKMFovWXVkNHFuMEFSYUFqL2xrSXJyS2dwQTMzcFJFQkRvbWQ5ZUMr?=
 =?utf-8?B?ODJpNDVhQnRVREtBTmhXMUExVGVhVDlMR1N0YzA5L3NRUlpHWnhNbko5NStt?=
 =?utf-8?B?VW9WUHVwc0FlRG5HZ3c2d0VXNzIzUVlVeGFvdDF0VW0zV2M3cGp5azVUeWdH?=
 =?utf-8?B?bnNaRkIxcE9GZmJSUnJ4cXcvdE5QeXBQVFFtM2pveG9HcHE4Z2UwQWxwZXE5?=
 =?utf-8?B?VzRMTlVhTk5GY1VHbUZjTy9kVXFPYXlEVkMvNTh0THY2Rzl2ZzZ0djE5dmJC?=
 =?utf-8?B?WUZKQ1J0d3lDNkJ4a1h1bmlqUk5aam1kdllFbTJtVjB3T2lTNmtXbmZVK1No?=
 =?utf-8?B?VWplNzltdnJQOU04M3Z4NzA5UWRvY3Fmd3JjR1FXYjRrNzA2TVlER1BnWmwr?=
 =?utf-8?B?UnNreXV6c3NFaWdodXptWlQvZVBYTk9uaDYxK2hRKzkzZVBxM2J4c3R3K0Nq?=
 =?utf-8?B?MXM4MlFNRSswUXJreVJTbEVuZk9rc25FTHBIMHlscVk0NFkwaGNLTDRlY1hM?=
 =?utf-8?B?K0hjM0tXUGU0bW1lbnVFVVpQUm91b0RFY1huVUNvbDBWdURIZHU1SW5mYWdL?=
 =?utf-8?B?WGJQYncxYlluRVZBdFU3dTgxdGhCaVB5R1FYZGtTdlN3VG9uR29kb255Zjho?=
 =?utf-8?B?UG15bHVwbzZxZVRSbWhmalh2RjMzcGlnTTJrSDZaRG5VZkJ6NitpemNmbHZH?=
 =?utf-8?B?dDNuaU91c29OWGpBYWF5SGhTQTh6TDlySW13eFRJd1V4Y1NLTHVYTklPNUk4?=
 =?utf-8?B?VFNDMHBGc0JadnZ0SUZyTHp5clJXTWZEUE0yNHZ6MUxhZ0hLaFp0ZExoTVh1?=
 =?utf-8?B?ZkFyT1NiT0tCYS95NWIzLytSaXdIeHhpNDVlQitOdXFkNlYzdDhRQUEwb0t6?=
 =?utf-8?B?M08wMHNMaGx5dndMemM3YkZIWDBqTnVtZHBZQmtSRVJrV0VZZW96WTh0K0pw?=
 =?utf-8?B?OVpYeWJrRXN2UHdZVGxCRmFEVG5NY21pUjkyYW93YTJ6VXFiTlpvcUFTeG94?=
 =?utf-8?B?QWxYdVhJNkEzVmNiVk85NktFZTRjSFQySG5xbW9GY000UUJhUUdreUlGS1F4?=
 =?utf-8?B?SlBhUEpwZGtFZTdnN0JLS2IzSDZyNzZZenBFaHFMV2RvTm4wRGo2R3JWSXNq?=
 =?utf-8?B?cVo4SHgwZTQ4bkRwTXhIWWhUc2diaW5ySTBJVXRWekpOUG1FM1NEWVNvdjUw?=
 =?utf-8?B?eS9Gc0FnODE5ZkU5TDVoeWdpMWFFbjZHTWQrSFVNc0xvMitVQjE1VHVxb3VJ?=
 =?utf-8?B?aFhoMUhXWXhMYUJnaW95djV6aG9rSnNHc1psMjJEdFRZQVoyRm1VOVpWaFpT?=
 =?utf-8?B?akhFQjhJRGQwSnpkVnlBOFl0WEJYRWdhTU5hSHpyVWthK3pvZFFHTCtJcExK?=
 =?utf-8?B?YUJURHgxUU9YUHFKdlNVcGJjRVI2RnZ0WmFPV2kzTG52cENtQ0ZUcHN6MERa?=
 =?utf-8?B?bmpQSFI3eVNCWm51T1cwcGVrTlZ2enhDUW92Z2lHdzdZdmtaK3l4cW1FMHNQ?=
 =?utf-8?B?YWt3RmRSNm1ScmJ0WTJoZDRsb1lHaFBadWRhcUdXUU5JUDd3R1RIRW16ZjQx?=
 =?utf-8?B?RlhnWm9qRmE2M1FycDErUTJMWXhSd3F6RFhKTUFRK0JzQnRQMmZwRHh2Y0ZG?=
 =?utf-8?B?WWxPRFpyRUgzSzV2dGRrL3Q2WGdGdGlHOGN5bWFMbmRmME1Tc2J6NHdPb2k3?=
 =?utf-8?B?d1hwc2FtcUdUdkhZeklFazFKbHdFKzRZZC9IUW96NWU5eEUxR2swWjIzZTV2?=
 =?utf-8?B?M3NrTTlOY0ZKa0FxVURWZUFhVWl2azNlWFNQVXo1MitScWVkY1BZZTFieDli?=
 =?utf-8?B?MllrclpIS0UwS0svMWUydEwyTVF6UURiSEFsQTk0TlFlZTkzaWtrVGlKNGVy?=
 =?utf-8?B?VXZ3bE1GcmR6Uzl4bHZMbDZlWlpuS0NiOU9EWWlkZGZ0MjFLWFVoTGFMb05n?=
 =?utf-8?B?a3EyNzJacnphcEY1b0lYUUJTTHdEOU9abmhtZDN0OGdDVnZMM0FBL0N2OFUv?=
 =?utf-8?Q?cdilte4vJJWT50XNGwBZ1jYvz?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5DEE2962CC63324D9BFDF276B17FAD28@namprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: citrix.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR03MB3623.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 611930d9-ea72-49a3-0459-08dab1a5c313
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Oct 2022 07:44:32.6245
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 335836de-42ef-43a2-b145-348c2ee9ca5b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: udpjHmfQvKt2ZbqMIeeTLW9nfyPsaHfP1NyrZvcBD7ZYnyjryf6HdZB1y6Dv5VpDr4j072XHmsRikBH6Rs1r5V8PlcOVVg1mx6E02XsLqxE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR03MB5399
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

T24gMDYvMDkvMjAyMiAxMTo0MSwgRXZnZW5peSBCYXNrb3Ygd3JvdGU6DQo+IGRpZmYgLS1naXQg
YS9hcmNoL3g4Ni9ib290L2NvbXByZXNzZWQvaGVhZF82NC5TIGIvYXJjaC94ODYvYm9vdC9jb21w
cmVzc2VkL2hlYWRfNjQuUw0KPiBpbmRleCBkMzNmMDYwOTAwZDIuLjUyNzMzNjcyODNiNyAxMDA2
NDQNCj4gLS0tIGEvYXJjaC94ODYvYm9vdC9jb21wcmVzc2VkL2hlYWRfNjQuUw0KPiArKysgYi9h
cmNoL3g4Ni9ib290L2NvbXByZXNzZWQvaGVhZF82NC5TDQo+IEBAIC02MTksOSArNjE5LDggQEAg
U1lNX0NPREVfU1RBUlQodHJhbXBvbGluZV8zMmJpdF9zcmMpDQo+ICAJLyogU2V0IHVwIG5ldyBz
dGFjayAqLw0KPiAgCWxlYWwJVFJBTVBPTElORV8zMkJJVF9TVEFDS19FTkQoJWVjeCksICVlc3AN
Cj4gIA0KPiAtCS8qIERpc2FibGUgcGFnaW5nICovDQo+IC0JbW92bAklY3IwLCAlZWF4DQo+IC0J
YnRybAkkWDg2X0NSMF9QR19CSVQsICVlYXgNCj4gKwkvKiBEaXNhYmxlIHBhZ2luZyBhbmQgc2V0
dXAgQ1IwICovDQo+ICsJbW92bAkkKENSMF9TVEFURSAmIH5YODZfQ1IwX1BHKSwgJWVheA0KDQpX
aHkgaGVyZT/CoCBXUCBpcyBpZ25vcmVkIHdoZW4gUEcgaXMgZGlzYWJsZWQuDQoNCn5BbmRyZXcN
Cg==
