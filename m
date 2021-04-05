Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DE7E354646
	for <lists+linux-efi@lfdr.de>; Mon,  5 Apr 2021 19:45:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233242AbhDERqB (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 5 Apr 2021 13:46:01 -0400
Received: from mail-mw2nam12on2111.outbound.protection.outlook.com ([40.107.244.111]:57760
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233140AbhDERqA (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Mon, 5 Apr 2021 13:46:00 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hVP93PaFjYFXnb2GU0irnnTitaNFJflZ13ZDJDt/tPQ3tcr4VmmKV7heIvcHml+8BpmBv71SsMo3RNyLYO3CRYQn/A/8v1UyMpml/5TwpmYIDMqoGPHAJIIikNal8bADyzti4gDl+n0KvgOw22xaSNu3R6zMCl8QoOz9PnKAFRZB8uJqHSa1CBgHBJUIm3NatV3DrLXSVe1+VQoDc6xoGBAhwi/3ITyr4TUR85TdfvvI/hNUNl2vOGKhtUjrrIr4KwzqM2vHh7gPLaEw8kex7PZdFRUfn6Bw1TpMsdql4rCuvfDw6Yqk8r5gch1s7CMGVSv5ENTXoYfX4vzYbH6afA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/qRPECD5vB+c6skWEi/wOCMyeJpY8HWlEY5pE40rSz8=;
 b=OyiHbJtgWP2oIzYkgjH2YdkZNpfQSYplMAxcAY+tXw+WuXyQMHs794WsnakXdCGYphB3AtGdQkKLn9QBNRDMunmgB1oE3R/KiyTsSIbTOBaPFXbZ3NnokbYDS4r6Bm9mbhQtXY1V5p22PWqMuUAcGXpasHwqMCYgGlyh6zL05TTiPJHz+/6aKQdI0hPsm1ySaPU7/x1QlGdewL98sEOcW107pgMZgG7XpiCV0u6B/vbfRyRGRrDEFY4ssjUIHvTDuSj8lfSSojHg/E1JMNhNBieFcnzVOafGrk05S3em1M+MIu98X3RQVw+5I16SQb4TA8JXE5GbRVeiUkgLEHRDZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/qRPECD5vB+c6skWEi/wOCMyeJpY8HWlEY5pE40rSz8=;
 b=M4jzcwL9UxS73jI2iQDWHPd0bmg1IGU8/7Ccox1CVPYE0Y9RiK1QCqh2V6bTNMo1iytKwTM6+IDG1fGca+Qy+JfPvWp7f/tALZ8QrbwtWZ2SAkc9YiTruZaUBQCWbUSqOlKQEYMeWNIb2q0KM+9c3n0mz1YLupkvxmZ7LRDX3ow=
Received: from MWHPR21MB1593.namprd21.prod.outlook.com (2603:10b6:301:7c::11)
 by MW4PR21MB1875.namprd21.prod.outlook.com (2603:10b6:303:72::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.4; Mon, 5 Apr
 2021 17:45:53 +0000
Received: from MWHPR21MB1593.namprd21.prod.outlook.com
 ([fe80::5874:413c:8f1b:6b0b]) by MWHPR21MB1593.namprd21.prod.outlook.com
 ([fe80::5874:413c:8f1b:6b0b%3]) with mapi id 15.20.4042.004; Mon, 5 Apr 2021
 17:45:53 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     Michael Kelley <mikelley@microsoft.com>,
        "will@kernel.org" <will@kernel.org>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        Mark Rutland <Mark.Rutland@arm.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "sudeep.holla@arm.com" <sudeep.holla@arm.com>
CC:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        "ardb@kernel.org" <ardb@kernel.org>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        KY Srinivasan <kys@microsoft.com>
Subject: RE: [PATCH v9 0/7] Enable Linux guests on Hyper-V on ARM64
Thread-Topic: [PATCH v9 0/7] Enable Linux guests on Hyper-V on ARM64
Thread-Index: AQHXFFVaB5wOH2JbNEut11B5j7WvKqqTYJ2ggBL8mAA=
Date:   Mon, 5 Apr 2021 17:45:52 +0000
Message-ID: <MWHPR21MB1593C7CFE86E45374FCB4839D7779@MWHPR21MB1593.namprd21.prod.outlook.com>
References: <1615233439-23346-1-git-send-email-mikelley@microsoft.com>
 <MWHPR21MB1593E68A0032D7344A42BD0DD7639@MWHPR21MB1593.namprd21.prod.outlook.com>
In-Reply-To: <MWHPR21MB1593E68A0032D7344A42BD0DD7639@MWHPR21MB1593.namprd21.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2021-03-24T15:54:56Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=6488edde-ca30-4fab-ada2-e40fa988c40f;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0
authentication-results: microsoft.com; dkim=none (message not signed)
 header.d=none;microsoft.com; dmarc=none action=none
 header.from=microsoft.com;
x-originating-ip: [24.22.167.197]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 85afa98e-ac57-4e12-b39a-08d8f85aa87b
x-ms-traffictypediagnostic: MW4PR21MB1875:
x-ms-exchange-transport-forked: True
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <MW4PR21MB1875359F8D993424D6C07385D7779@MW4PR21MB1875.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0voqwSFMD2YgAyAMGDx6+2fTm+xbvH80j3/0TE9WRXiBM4E0TiuP0cOR8lKGAE9OGqDRXjXnzy93P6IrmCxWfj1tjxe/unsz5pmQHFayIysihuVbJrzMlKdl+wLq7ODLiXlr52dz4QjOWD+7JHLUtzzxkUaYMDCQxWYp0IinagOe9XQvk0Ln37DbX1hoKtgoJKhHTP+6BaMGMnIghjQdE/F9AUkkNi3D3SlRn2OCS2oOKDwE53wYEH1fxy45US2furAtCqAKGdiweRfScR59jwVOz6GbyWaCQ4KmKZ83v7l86uBZeZON0yScr8xR9K83zU4J1HbgjrweWl6YjImOrdygE/lZqRbxXpbNFeW8Tg1XsgL8LGv0lKU1WS0ZhO8qWjcF8xHtFfCrw98VALDPEONP8R9Cm9Or79HgffKz22716Y4dvvypY3fbTDKKALfNEca7LOZMlrx/q0awWWmfVjQ+YyhSxNMrQUge0n0NeFqUF6PC6grXZndSd9JO+mntuOGWs6I4Y/RSoN2mA92d86EwdBPkOz/S2XjCb1z8WiOaYdtQsxW1wNU+/vU+yn+bk0JVwdQxkw0zKzRcmasQieY20GDi+LUiJOE3CG7ZX8IOJ6zVBTvG36bIrEwZbvPkC+ycAWYLmctcl2QgpV3/RKiIQyzCYCvlKjso7ZVw220=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR21MB1593.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(366004)(346002)(136003)(39860400002)(376002)(9686003)(8990500004)(71200400001)(55016002)(82960400001)(82950400001)(107886003)(26005)(86362001)(6506007)(316002)(54906003)(2906002)(110136005)(53546011)(10290500003)(52536014)(478600001)(64756008)(66476007)(5660300002)(66556008)(76116006)(38100700001)(8676002)(66946007)(186003)(4326008)(7416002)(8936002)(33656002)(7696005)(66446008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?scBepA2o1r7dImKAoXY3Rrybcz6DvayWQuVZGu2S3F56aslxQZ3PHj5ckjEU?=
 =?us-ascii?Q?7dc+2HHw8FSwiNcSQ2qUzeukKxrZT4KfXEm0Hy8PEBw+hnFNmgZuhJ9Gppz9?=
 =?us-ascii?Q?poOx1GCQFrl3cdYdemdDvL5OLloL1699OqVLHYdx1TJeIoCcQqAY63IqjNyK?=
 =?us-ascii?Q?EsqvUiwTlfb+mTGYkJEQo0izZFR7ltJHAlG+oKkEqcyQ0/bxB149O9eA8Kgg?=
 =?us-ascii?Q?/j/DkX5MVoGljCe8d8Fh0+9cICZl42SKhO65TkN45/TXCW0Dq8HK3jkNMNtm?=
 =?us-ascii?Q?IxdjCowFpK0/owHPqZuv6ff6GS9Sb+WDV0UDocIRu0l3laLKyRZA1py7Uq//?=
 =?us-ascii?Q?C/4Fed0aTtc3f3ZqBF93NieR5GtnB3aUSSFSUaIrCMZ7kUl3+VyV6bVXJK5P?=
 =?us-ascii?Q?dOEr3cCsPn9kTOdY3EScUXN1dQS01P/KFimYQ/2r2kfNOoiIi+Uh5wQdZEdE?=
 =?us-ascii?Q?mLZBMj+1F5xNkhNf2WGBURmNJXN9iazUqv75JHb0qFg20VxtXU/4jA5HF2z7?=
 =?us-ascii?Q?MwzHcYYeOX5M/IQzJRm/Wz3uJTNzeimnyXeB6lrQVuQX4XismEoGFYnQ6uUE?=
 =?us-ascii?Q?e1m1DflEE6xE+7513Lt1bTOIzbehMeE/tT36a+92ROVpdJGJGhyXl63RQn1E?=
 =?us-ascii?Q?OxqfF/lhmxr+gPOgz8A/wnEbv9u1zGY8O1JyCCqFd6LuHxr/WJMxxD6OeY4B?=
 =?us-ascii?Q?2QaVkuzJGD7VKkbNZykTBg7+obBfyLyb0eGCabDebOgWIYGvqO6iQQmP0zn9?=
 =?us-ascii?Q?xDiPUgzz15HtfOeWT6kMEQujSRca2V4zE31DD2AawVQnI7QXor3V0YuwXLt5?=
 =?us-ascii?Q?2S3wmF2BwIuEeBB3neRMWs0k25zXK/GyPX0+EMH7y+8CnpVbWsviob8wTeiH?=
 =?us-ascii?Q?/+oADtlLBj3gpu6oLI2YTJ2pmYFdjihHVh7A/acdLIJwYZaZKHUH3Sf4tgtB?=
 =?us-ascii?Q?Bbd64xVo6lQe84cC3XaCiuJi8gZ2HfsSEp2kHsJNlQUC7n+NoO3diJf3l9rA?=
 =?us-ascii?Q?6tA2iwiN4yk7QLJEM3/RQ7ZMN4sCKPdtU9yRHw3TjlP6fSfR9eNelmTzDtrh?=
 =?us-ascii?Q?UZIiGkiuq0qtGYIG5oVuwOYH0KmHvc93mTLrMBPs/4DcqmccQJkI8o72Z+zC?=
 =?us-ascii?Q?73roZf/y02bJWxDucelbAKbW/sLI9p0Q0VjndpASm1R/sV0L/swJaQ9uV+83?=
 =?us-ascii?Q?VMZJNBzm7hG8Wanbt1kJzjcgfFKWJY7DMLAYilKYJGBnhXrQipGaMbUvK35h?=
 =?us-ascii?Q?0vjbyP2kg6WTp4yql5W0tn4lH2JM9ImDuv09rACHQHrOsygLmrS8jEjfQhRs?=
 =?us-ascii?Q?QtYx3/O5Q1bLZHJB+SAqkWj9?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR21MB1593.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85afa98e-ac57-4e12-b39a-08d8f85aa87b
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Apr 2021 17:45:52.6881
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AP0JGToLLCQNSvxCGwrXKOXCrWFNmb0eJEtkiiAJ+yelLQfzX32kx28ciY1SiT3cUYBBMGDKyRNhwnUpFIErSxwx55MaRzKcNyoxwM4wuxM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR21MB1875
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

From: Michael Kelley <mikelley@microsoft.com>
> Sent: Wednesday, March 24, 2021 8:55 AM
> To: will@kernel.org; catalin.marinas@arm.com; Mark Rutland <Mark.Rutland@=
arm.com>;
> lorenzo.pieralisi@arm.com; sudeep.holla@arm.com
> Cc: linux-arm-kernel@lists.infradead.org; linux-kernel@vger.kernel.org; l=
inux-
> hyperv@vger.kernel.org; linux-efi@vger.kernel.org; arnd@arndb.de; wei.liu=
@kernel.org;
> ardb@kernel.org; daniel.lezcano@linaro.org; KY Srinivasan <kys@microsoft.=
com>
> Subject: RE: [PATCH v9 0/7] Enable Linux guests on Hyper-V on ARM64
>=20
> From: Michael Kelley <mikelley@microsoft.com> Sent: Monday, March 8, 2021=
 11:57 AM
> >
> > This series enables Linux guests running on Hyper-V on ARM64
> > hardware. New ARM64-specific code in arch/arm64/hyperv initializes
> > Hyper-V, including its interrupts and hypercall mechanism.
> > Existing architecture independent drivers for Hyper-V's VMbus and
> > synthetic devices just work when built for ARM64. Hyper-V code is
> > built and included in the image and modules only if CONFIG_HYPERV
> > is enabled.
>=20
> ARM64 maintainers --
>=20
> What are the prospects for getting your review and Ack on this patch set?
> We're wanting to get the Hyper-V support on ARM64 finally accepted upstre=
am.
> Previous comments should be addressed in this revision, with perhaps a
> remaining discussion point around the alternate SMCCC hypercall interface
> in Patch 1 that makes use of changes in v1.2 of the SMCCC spec.  There ar=
e
> several viable approaches that I've noted in the patch, depending on
> your preferences.
>=20
> Michael

Thanks, Mark, for jumping in on the SMCCC hypercall interface.  But I'm sti=
ll
looking for feedback or ACKs on the other patches in the series.  There's o=
nly
one place in Patch 2 of the series that needs the SMCCC v1.2 interface, and=
 I'd
like to be able to respond to any remaining issues with the other patches
while the SMCCC details are finished up.

Michael
