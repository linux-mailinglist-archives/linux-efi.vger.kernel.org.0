Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 93525D5790
	for <lists+linux-efi@lfdr.de>; Sun, 13 Oct 2019 21:09:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728786AbfJMTId (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sun, 13 Oct 2019 15:08:33 -0400
Received: from mx0b-00154904.pphosted.com ([148.163.137.20]:40844 "EHLO
        mx0b-00154904.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728481AbfJMTIc (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sun, 13 Oct 2019 15:08:32 -0400
Received: from pps.filterd (m0170394.ppops.net [127.0.0.1])
        by mx0b-00154904.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x9DJ5Ww3032630;
        Sun, 13 Oct 2019 15:08:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=smtpout1;
 bh=c9YILNJ4iUU58iN/re0KxKHUTwTlvJMbTiMStKhHBwc=;
 b=mrbaIXjx7zErZGGPo+HQZDIgrXUUriYKMQQgG6kLA8hJnHZRxmb9fQ0pj+7fyUvLjqqm
 Cvl9K0Wic9nuxbPc9V2VdchSxULKGIFoRSeFjmN8AQITjK0fUVPsYrrAW4FxShT5Tmqd
 YNx+pggbe5t0A8JQtad58Rk855fXDcU+P9WFDoOOM5y4VrnnJ/XrOo+y0xB0F4fTm3kI
 i5BYQznyCIkC2YVqIEAKAnwx0LG+edKRXKZdN36I85uFQM2hAv3Z9m1XER+HRZFcNUbS
 OdmfiTOaqJfPHJclkjQaH3hq8tWlc7zFu2kNKeuuhmEoL745/OcFs9rhhWhv8TR00q2h hg== 
Received: from mx0b-00154901.pphosted.com (mx0b-00154901.pphosted.com [67.231.157.37])
        by mx0b-00154904.pphosted.com with ESMTP id 2vk9d7cqqc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 13 Oct 2019 15:08:31 -0400
Received: from pps.filterd (m0144102.ppops.net [127.0.0.1])
        by mx0b-00154901.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x9DJ7bwK069301;
        Sun, 13 Oct 2019 15:08:30 -0400
Received: from ausc60ps301.us.dell.com (ausc60ps301.us.dell.com [143.166.148.206])
        by mx0b-00154901.pphosted.com with ESMTP id 2vkmk1t6r5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 13 Oct 2019 15:08:30 -0400
X-LoopCount0: from 10.166.132.134
X-PREM-Routing: D-Outbound
X-IronPort-AV: E=Sophos;i="5.60,349,1549951200"; 
   d="scan'208";a="1363406669"
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
Thread-Index: AQHVeVm8hd3/NfhPNEW1ErxPMn2a1adSB94AgAHOtgCAABHEgIAA+WUAgAAFC4CAADBvAIAB2AmAgAG094A=
Date:   Sun, 13 Oct 2019 19:08:24 +0000
Message-ID: <20191013190813.GA2742@localhost.localdomain>
References: <20191002194346.GA3792@localhost.localdomain>
 <CAKv+Gu9_xX3RgDNGB=T83vhg_snMKe0F2YPKp1S2o2toNHHZZQ@mail.gmail.com>
 <20191010174710.GA2405@localhost.localdomain>
 <CAMuHMdVriPMVWdNOD4ytZQFPmad7CvD_4utbw1PxMJBua1TSfQ@mail.gmail.com>
 <20191011094322.GA3065@localhost.localdomain>
 <CAMuHMdUMkyyCZACyJ7dvd4SaicpN77g5pFd0aGEzQW_q7m3Q0g@mail.gmail.com>
 <20191011125446.GA2170@localhost.localdomain>
 <CAMuHMdWALc_hneRaiwQbMWUXe=LnVqU7dkkWibV0cqb8Gc5e0g@mail.gmail.com>
In-Reply-To: <CAMuHMdWALc_hneRaiwQbMWUXe=LnVqU7dkkWibV0cqb8Gc5e0g@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mutt/1.10.1 (2018-07-13)
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.143.18.86]
Content-Type: text/plain; charset="us-ascii"
Content-ID: <69878A1FDCC3E249860E6AA63127CBC6@dell.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-10-13_09:2019-10-10,2019-10-13 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 phishscore=0 mlxscore=0 bulkscore=0 clxscore=1011 mlxlogscore=999
 suspectscore=0 priorityscore=1501 adultscore=0 spamscore=0 malwarescore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1908290000 definitions=main-1910130191
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 impostorscore=0
 lowpriorityscore=0 clxscore=1015 mlxlogscore=999 bulkscore=0
 suspectscore=0 spamscore=0 priorityscore=1501 malwarescore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1908290000 definitions=main-1910130191
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Geert,

On Sat, Oct 12, 2019 at 07:04:15PM +0200, Geert Uytterhoeven wrote:
[...]
> > From the discussion in [1] and [2](pasted a part of it above), my under=
standing
> > of the issue you reported is that 'make oldconfig' asks the user a ques=
tion for arm64
> > though the EFI_RCI2_TABLE is not relevant for arm64. From the tests,
> > it seemed like adding "depends on X86 || COMPILE_TEST" does not fix the
> > issue, splitting bool into bool + prompt fixes it.
> >
> > Please let me know if I am missing any detail in the issue you reported=
.
>=20
> Adding a "depends on X86 || COMPILE_TEST" should fix the issue, as
> X86 is never set on arm64, nor on any other architecture than X86.
> If COMPILE_TEST=3Dy, it's normal expected behavior to show the question.

Ok. Thank you for the details.=20

>=20
> > With the way EFI_RCI2_TABLE is currently defined, my understanding is
> > that 'make oldconfig' does not set the EFI_RCI2_TABLE to 'y' by default
> > on arm64, but it asks the user the question. User has to say 'y' if he
> > wants it to be set to 'y', else by default 'n' is set. This behavior is
> > as expected.
>=20
> If the option doesn't make sense on arm64 (more broadly: on non-X86),
> it should depend on X86 || COMPILE_TEST, to avoid spamming the user
> with (zillions of) options that do not matter for his platform.

Ok.

>=20
> > > One common approach is to let the Kconfig symbol for the platform (no=
t for
> > > all of X86!) select EFI_RCI2_TABLE.
> > > That way it will be enabled automatically when needed.
> >
> > We did not intend to enable EFI_RCI2_TABLE option by default even on al=
l
> > X86 systems from the begining. As a result, we chose to set it to 'n' b=
y
> > default and added the guidance in 'help' section to say 'y' for Dell EM=
C
> > PowerEdge systems.
>=20
> Good.
>=20
> >> > Another approach is to not force the option on, but guide the user t=
owards
> > > enabling it, by adding "default y if <platform_symbol>".
> >
> > As mentioned above, we want to keep the default to n.
>=20
> OK.
>=20
> > > Without the "|| COMPILE_TEST", you cannot enable compile-testing of
> > > the driver on non-x86 platforms with EFI.
> >
> > Ok. We could keep the check. Could we make it independent of platforms
> > by adding 'defbool y if COMPILE_TEST' ?
>=20
> Please don't do that, as it with always enable the driver if COMPILE_TEST=
=3Dy,
> without providing a way to opt-out for the user.

Ok.

Thank you for the inputs.=20

I have submitted the patch with 'depends on X86 || COMPILE_TEST' added to=20
the Kconfig file. Could you please help test it on your platform/system to=
=20
verify if the patch works as expected ?=20

--=20
With regards,
Narendra K=
