Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C0010D3FFF
	for <lists+linux-efi@lfdr.de>; Fri, 11 Oct 2019 14:55:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728109AbfJKMzV (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 11 Oct 2019 08:55:21 -0400
Received: from mx0a-00154904.pphosted.com ([148.163.133.20]:47890 "EHLO
        mx0a-00154904.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728033AbfJKMzU (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 11 Oct 2019 08:55:20 -0400
Received: from pps.filterd (m0170392.ppops.net [127.0.0.1])
        by mx0a-00154904.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x9BCt9vU008412;
        Fri, 11 Oct 2019 08:55:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=smtpout1;
 bh=k1tI6exljFfm3+StUh8XvsNFdSkCQrGl3UGrix+7rYc=;
 b=omjJpoXBv0h9tBUhbv8PJnkk6XtfYFMLONfojF2T1or5BUu2drUyesw3i9u6oOO9yVCA
 0XOez+s2h2mDW1HembV9D46FuLvBtdUAHoFQIaC3AQQkVPdDYS+JNubvIdWPuWJXjVwV
 32N0eN9+CfSQudqhaSfixaD+aT0oj1mboowiMM0cXbBrAPUQFz2s+N2yGlsXjHvFXBvz
 Cg72lDeh+2qWUFdBNiGyH25trKtheGuvzQGlIT6j5c4fjjsJ5xr8rlb8t9eT5LXWnQ0e
 fw1pDrhYSnpyX4TlVCZ4Kpgwp0J4PSsveMQzEufCne95wQOfjcSlQYa6iD6QgpicFdWs JQ== 
Received: from mx0b-00154901.pphosted.com (mx0b-00154901.pphosted.com [67.231.157.37])
        by mx0a-00154904.pphosted.com with ESMTP id 2vepbfpd38-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 11 Oct 2019 08:55:19 -0400
Received: from pps.filterd (m0144103.ppops.net [127.0.0.1])
        by mx0b-00154901.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x9BCrBdw024395;
        Fri, 11 Oct 2019 08:55:18 -0400
Received: from ausxippc101.us.dell.com (ausxippc101.us.dell.com [143.166.85.207])
        by mx0b-00154901.pphosted.com with ESMTP id 2vjj02f0vq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 11 Oct 2019 08:55:18 -0400
X-LoopCount0: from 10.166.132.130
X-PREM-Routing: D-Outbound
X-IronPort-AV: E=Sophos;i="5.60,346,1549951200"; 
   d="scan'208";a="1310933796"
From:   <Narendra.K@dell.com>
To:     <geert@linux-m68k.org>
CC:     <ard.biesheuvel@linaro.org>, <linux-efi@vger.kernel.org>,
        <Mario.Limonciello@dell.com>, <tglx@linutronix.de>,
        <linux-kernel@vger.kernel.org>, <james.morse@arm.com>,
        <mingo@kernel.org>
Subject: Re: [PATCH] Ask user input only when CONFIG_X86 or
 CONFIG_COMPILE_TEST is set to y
Thread-Topic: [PATCH] Ask user input only when CONFIG_X86 or
 CONFIG_COMPILE_TEST is set to y
Thread-Index: AQHVeVm8hd3/NfhPNEW1ErxPMn2a1adSB94AgAHOtgCAABHEgIAA+WUAgAAFC4CAADBvAA==
Date:   Fri, 11 Oct 2019 12:55:12 +0000
Message-ID: <20191011125446.GA2170@localhost.localdomain>
References: <20191002194346.GA3792@localhost.localdomain>
 <CAKv+Gu9_xX3RgDNGB=T83vhg_snMKe0F2YPKp1S2o2toNHHZZQ@mail.gmail.com>
 <20191010174710.GA2405@localhost.localdomain>
 <CAMuHMdVriPMVWdNOD4ytZQFPmad7CvD_4utbw1PxMJBua1TSfQ@mail.gmail.com>
 <20191011094322.GA3065@localhost.localdomain>
 <CAMuHMdUMkyyCZACyJ7dvd4SaicpN77g5pFd0aGEzQW_q7m3Q0g@mail.gmail.com>
In-Reply-To: <CAMuHMdUMkyyCZACyJ7dvd4SaicpN77g5pFd0aGEzQW_q7m3Q0g@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mutt/1.10.1 (2018-07-13)
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.143.18.86]
Content-Type: text/plain; charset="us-ascii"
Content-ID: <A2717FECB6566849A28C4AB7B68DDB68@dell.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-10-11_08:2019-10-10,2019-10-11 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 adultscore=0 mlxlogscore=999 impostorscore=0 bulkscore=0 clxscore=1015
 spamscore=0 mlxscore=0 priorityscore=1501 suspectscore=0 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1908290000 definitions=main-1910110122
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0 spamscore=0
 impostorscore=0 priorityscore=1501 suspectscore=0 bulkscore=0 phishscore=0
 mlxlogscore=999 lowpriorityscore=0 mlxscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-1908290000
 definitions=main-1910110123
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, Oct 11, 2019 at 12:01:25PM +0200, Geert Uytterhoeven wrote:
> > > > > > -       bool "EFI Runtime Configuration Interface Table Version=
 2 Support"
> > > > > > +       bool
> > > > > > +       prompt "EFI RCI Table Version 2 Support" if X86 || COMP=
ILE_TEST
> > >
> > > Why the split of bool and prompt?
> > > Why not simply add a single line "depends on X86 || COMPILE_TEST"?
> >
> > It is because of the findings shared in [1]. Please let me know your
> > thoughts on the findings.
>=20
> So you want to prevent the user from seeing a prompt for an option he may
> or may not need to enable, when running "make oldconfig"?

Geert,

> The code in question is entirely architecture agnostic, and defaults
> to 'n', so I am not convinced this is needed. (It came up in the
> review as well)

>> "make oldconfig" still asks me the question on e.g. arm64, where it is
>> irrelevant, until arm64 variants of the hardware show up.

>> So IMHO it should have "depends on X86 || COMPILE_TEST".

From the discussion in [1] and [2](pasted a part of it above), my understan=
ding
of the issue you reported is that 'make oldconfig' asks the user a question=
 for arm64
though the EFI_RCI2_TABLE is not relevant for arm64. From the tests,
it seemed like adding "depends on X86 || COMPILE_TEST" does not fix the
issue, splitting bool into bool + prompt fixes it.

Please let me know if I am missing any detail in the issue you reported. =20

With the way EFI_RCI2_TABLE is currently defined, my understanding is
that 'make oldconfig' does not set the EFI_RCI2_TABLE to 'y' by default
on arm64, but it asks the user the question. User has to say 'y' if he
wants it to be set to 'y', else by default 'n' is set. This behavior is
as expected.=20

>=20
> One common approach is to let the Kconfig symbol for the platform (not fo=
r
> all of X86!) select EFI_RCI2_TABLE.
> That way it will be enabled automatically when needed.

We did not intend to enable EFI_RCI2_TABLE option by default even on all
X86 systems from the begining. As a result, we chose to set it to 'n' by
default and added the guidance in 'help' section to say 'y' for Dell EMC
PowerEdge systems.=20

>=20
> Another approach is to not force the option on, but guide the user toward=
s
> enabling it, by adding "default y if <platform_symbol>".

As mentioned above, we want to keep the default to n.

> Without the "|| COMPILE_TEST", you cannot enable compile-testing of
> the driver on non-x86 platforms with EFI.

Ok. We could keep the check. Could we make it independent of platforms
by adding 'defbool y if COMPILE_TEST' ?=20

[1] Re: [PATCH 4/5] efi: Export Runtime Configuration Interface table to sy=
sfs
https://lore.kernel.org/linux-efi/20190812150452.27983-5-ard.biesheuvel@lin=
aro.org/T/#m0d73b4fa0dd7ece5038e4c9580dcc4e2ce5bd63c

[2] Re: [PATCH 4/5] efi: Export Runtime Configuration Interface table to sy=
sfs
https://lore.kernel.org/linux-efi/20190812150452.27983-5-ard.biesheuvel@lin=
aro.org/T/#mf45a9bc1861c71f110c800a53c60f0be65c68ec7
--=20
With regards,
Narendra K=
