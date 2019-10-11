Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3112AD3C98
	for <lists+linux-efi@lfdr.de>; Fri, 11 Oct 2019 11:43:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727453AbfJKJnu (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 11 Oct 2019 05:43:50 -0400
Received: from mx0b-00154904.pphosted.com ([148.163.137.20]:1552 "EHLO
        mx0b-00154904.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727167AbfJKJnu (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 11 Oct 2019 05:43:50 -0400
Received: from pps.filterd (m0170398.ppops.net [127.0.0.1])
        by mx0b-00154904.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x9B9e8Ow016641;
        Fri, 11 Oct 2019 05:43:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=smtpout1;
 bh=w46NJE6fW68I4yvn1RqKnCFjCbk8molouLVlhQc9FeA=;
 b=qabMtOsSmUadoVccB23epu7AjgmpQUxbqmg3ro4rCyl0bZ4LiVK8VnZDY44S/GdnWVhm
 L5DcjJNrMIgjORGzCFOFmm/q9sk0+4Ypo9lMLog4TP1n+nS1Bt9TO1tO+b+ympgtOr9w
 V5ruZQ3curP970Ax0LgNWo6JdInbvxnHJw399Quo/zOxH6fA26UmOOhcQmYWjnXvS+nP
 8/d1+CnbrwuuWd9K22QPCFvOGlAZMevWP/VRl5wPrAflTpojPWH+XPWHoVS4LUHdj8cC
 eq9bX/Iuq0V/MBykBuYhgloKUFDXGijEEiCUG6QXSOlittsYra5wfy0ymPGx2xJPi5Ll tQ== 
Received: from mx0b-00154901.pphosted.com (mx0b-00154901.pphosted.com [67.231.157.37])
        by mx0b-00154904.pphosted.com with ESMTP id 2vepdawe64-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 11 Oct 2019 05:43:48 -0400
Received: from pps.filterd (m0144103.ppops.net [127.0.0.1])
        by mx0b-00154901.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x9B9gscg114295;
        Fri, 11 Oct 2019 05:43:48 -0400
Received: from ausxippc110.us.dell.com (AUSXIPPC110.us.dell.com [143.166.85.200])
        by mx0b-00154901.pphosted.com with ESMTP id 2vjj02cgvj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 11 Oct 2019 05:43:47 -0400
X-LoopCount0: from 10.166.132.132
X-PREM-Routing: D-Outbound
X-IronPort-AV: E=Sophos;i="5.60,349,1549951200"; 
   d="scan'208";a="868557033"
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
Thread-Index: AQHVeVm8hd3/NfhPNEW1ErxPMn2a1adSB94AgAHOtgCAABHEgIAA+WUA
Date:   Fri, 11 Oct 2019 09:43:42 +0000
Message-ID: <20191011094322.GA3065@localhost.localdomain>
References: <20191002194346.GA3792@localhost.localdomain>
 <CAKv+Gu9_xX3RgDNGB=T83vhg_snMKe0F2YPKp1S2o2toNHHZZQ@mail.gmail.com>
 <20191010174710.GA2405@localhost.localdomain>
 <CAMuHMdVriPMVWdNOD4ytZQFPmad7CvD_4utbw1PxMJBua1TSfQ@mail.gmail.com>
In-Reply-To: <CAMuHMdVriPMVWdNOD4ytZQFPmad7CvD_4utbw1PxMJBua1TSfQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mutt/1.10.1 (2018-07-13)
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.143.242.75]
Content-Type: text/plain; charset="us-ascii"
Content-ID: <240142C8A4ECD24A9834C28B13889B14@dell.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-10-11_06:2019-10-10,2019-10-11 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 adultscore=0 mlxlogscore=999 impostorscore=0 bulkscore=0 clxscore=1015
 spamscore=0 mlxscore=0 priorityscore=1501 suspectscore=0 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1908290000 definitions=main-1910110092
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 spamscore=0
 suspectscore=0 adultscore=0 mlxlogscore=999 clxscore=1015
 lowpriorityscore=0 bulkscore=0 impostorscore=0 malwarescore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1908290000 definitions=main-1910110091
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hi Geert,

On Thu, Oct 10, 2019 at 08:50:45PM +0200, Geert Uytterhoeven wrote:
[...]
> > > >  drivers/firmware/efi/Kconfig | 5 ++++-
> > > >  1 file changed, 4 insertions(+), 1 deletion(-)
> > > >
> > > > diff --git a/drivers/firmware/efi/Kconfig b/drivers/firmware/efi/Kc=
onfig
> > > > index 178ee8106828..6e4c46e8a954 100644
> > > > --- a/drivers/firmware/efi/Kconfig
> > > > +++ b/drivers/firmware/efi/Kconfig
> > > > @@ -181,7 +181,10 @@ config RESET_ATTACK_MITIGATION
> > > >           reboots.
> > > >
> > > >  config EFI_RCI2_TABLE
> > > > -       bool "EFI Runtime Configuration Interface Table Version 2 S=
upport"
> > > > +       bool
> > > > +       prompt "EFI RCI Table Version 2 Support" if X86 || COMPILE_=
TEST
>=20
> Why the split of bool and prompt?
> Why not simply add a single line "depends on X86 || COMPILE_TEST"?

It is because of the findings shared in [1]. Please let me know your
thoughts on the findings.

>=20
> > >
> > > You can drop the || COMPILE_TEST as well.
> >
> > I will drop this part of the change in the next version of the patch.
>=20
> Why drop that part? Isn't it good to have more compile test coverage?

It is per the suggestion in the previous review comment.=20

Ard, please share your thought here. I could add the || COMPILE_TEST.

[1]  Re: [PATCH 4/5] efi: Export Runtime Configuration Interface table to s=
ysfs
https://lore.kernel.org/linux-efi/20190812150452.27983-1-ard.biesheuvel@lin=
aro.org/T/#mebff9ba48499808f59b33b2daef2d94e006296d8

--=20
With regards,
Narendra K=
