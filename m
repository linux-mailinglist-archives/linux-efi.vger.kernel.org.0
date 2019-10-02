Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6407FC4B64
	for <lists+linux-efi@lfdr.de>; Wed,  2 Oct 2019 12:27:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727851AbfJBK1P (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 2 Oct 2019 06:27:15 -0400
Received: from mx0a-00154904.pphosted.com ([148.163.133.20]:7012 "EHLO
        mx0a-00154904.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727807AbfJBK1P (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 2 Oct 2019 06:27:15 -0400
Received: from pps.filterd (m0170392.ppops.net [127.0.0.1])
        by mx0a-00154904.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x92AJp6s030547;
        Wed, 2 Oct 2019 06:27:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=smtpout1;
 bh=ntR22ytiVGn5A9fSHOxPwnmg9Y4gCQnz9sNO26eQOV4=;
 b=mxhRwDHuLrYio4yRpn3ddZVSDO8TxVtDz0+D4fNUUydpmTZMQFVfyX6RgmEk4uE6+q1Q
 7tjiechjtKjcVtBs+pSltB5o1hRozTZEzFYwQveiXZ5soya3gsOsVpOlerXCADU7cHtt
 A6ijKEVTMr8s+Y03kWJ1ebomL/H2XUIfakR0Y/zHfzQZwop4HWGAxnvk0CMva1j8caBI
 L8KEaReK+9DMxmWMdk7TecRxbUeS5xudr525hzcz458yXtTfu2Wd+ykHfxVqG3BiNZID
 W4sYD3bfg8cbvnSZ2zo+Ykcwq2AVpnUth69s7ISBHA7LYfiWWFiKgb7yI6UrVXSoW2bw 1A== 
Received: from mx0b-00154901.pphosted.com (mx0a-00154901.pphosted.com [67.231.149.39])
        by mx0a-00154904.pphosted.com with ESMTP id 2va2pet5gn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 02 Oct 2019 06:27:14 -0400
Received: from pps.filterd (m0090350.ppops.net [127.0.0.1])
        by mx0b-00154901.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x92AMrro050573;
        Wed, 2 Oct 2019 06:27:14 -0400
Received: from ausxipps306.us.dell.com (AUSXIPPS306.us.dell.com [143.166.148.156])
        by mx0b-00154901.pphosted.com with ESMTP id 2vca1w5psb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 02 Oct 2019 06:27:14 -0400
X-LoopCount0: from 10.166.134.84
X-PREM-Routing: D-Outbound
X-IronPort-AV: E=Sophos;i="5.60,349,1549951200"; 
   d="scan'208";a="382383860"
From:   <Narendra.K@dell.com>
To:     <geert@linux-m68k.org>
CC:     <Mario.Limonciello@dell.com>, <ard.biesheuvel@linaro.org>,
        <linux-efi@vger.kernel.org>, <mingo@kernel.org>,
        <tglx@linutronix.de>, <linux-kernel@vger.kernel.org>,
        <james.morse@arm.com>, <tanxiaofei@huawei.com>,
        <Narendra.K@dell.com>
Subject: Re: [PATCH 4/5] efi: Export Runtime Configuration Interface table to
 sysfs
Thread-Topic: [PATCH 4/5] efi: Export Runtime Configuration Interface table to
 sysfs
Thread-Index: AQHVUR9fTJBv0Z/1EU2zTW0DTQ5+k6dFbG6AgAAA2ACAAAKAgIAACpuAgAA9PgCAAE5zgIAABjuAgAELs4A=
Date:   Wed, 2 Oct 2019 10:22:10 +0000
Message-ID: <20191002102159.GA2109@localhost.localdomain>
References: <20190812150452.27983-1-ard.biesheuvel@linaro.org>
 <20190812150452.27983-5-ard.biesheuvel@linaro.org>
 <CAMuHMdXY5UH4KhcaNVuxa8-+GN-4bjyvCd0wzPYuFBY5Ch=fNA@mail.gmail.com>
 <CAKv+Gu-KPypju6roQaVKP0DHE3aZijVVqLGwNyhiRSNqn1r6-w@mail.gmail.com>
 <CAMuHMdV9m+Dbch46cVNqtn4cyB74qgHa18Qcm=HQv7Wx1rk==w@mail.gmail.com>
 <CAKv+Gu9iLxkJgmxZR+1yvCTj6GiCDuyfN_QiGXEWBHS7uYUbfQ@mail.gmail.com>
 <8446d19dd197447a88eed580601f3c4c@AUSX13MPC105.AMER.DELL.COM>
 <20191001180133.GA2279@localhost.localdomain>
 <CAMuHMdUMh4mCczCOxFtLn3E0Wu84ixFBsFuXk0p9QVXtg4dmoQ@mail.gmail.com>
In-Reply-To: <CAMuHMdUMh4mCczCOxFtLn3E0Wu84ixFBsFuXk0p9QVXtg4dmoQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mutt/1.10.1 (2018-07-13)
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.143.242.75]
Content-Type: text/plain; charset="us-ascii"
Content-ID: <609E97DE5EAE6D4AB612FBFE021B3135@dell.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-10-02_06:2019-10-01,2019-10-02 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 phishscore=0
 mlxscore=0 malwarescore=0 priorityscore=1501 lowpriorityscore=0
 clxscore=1015 spamscore=0 mlxlogscore=999 bulkscore=0 impostorscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1908290000 definitions=main-1910020097
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0 phishscore=0
 malwarescore=0 bulkscore=0 impostorscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxlogscore=999 priorityscore=1501 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-1908290000
 definitions=main-1910020097
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue, Oct 01, 2019 at 08:23:51PM +0200, Geert Uytterhoeven wrote:
[...]
> > > > > > > > +config EFI_RCI2_TABLE
> > > > > > > > +       bool "EFI Runtime Configuration Interface Table Ver=
sion 2 Support"
[...]
> > > Is it really a problem to just say n?
> > >
> > > I think this seems like a needless change that would slow down adopti=
on of
> > > !x86 if Dell EMC PowerEdge systems did start going that route, especi=
ally
> > > when it comes to distributions that move glacially slow with picking =
up new
> > > kernel code.
> >
> > Hi Ard/Geert,
> >
> > Any additional thoughts here ?
>=20
> Sure ;-)
>=20
> A typical platform-specific sarm/arm64 .config file has almost 3000
> config options
> disabled.  Hence that means I have to say "n" almost 3000 times.
> Fortunately I started doing this several years ago, so I can do this
> incrementally ;-)
>=20
> Perhaps someone should try to remove all lines like "depends on ... ||
> COMPILE_TEST", run "make oldconfig", read all help texts before saying "n=
",
> and time the whole operation...
>=20
> I hope I managed to convince you of the benefits.

Thank you Geert. The description is helpful. I am working on it.=20
As I understand, the issue is 'make oldconfig' provides a prompt to the use=
r=20
and user is expecting that a prompt is not needed as the option is not
relevant.

I cloned upstream kernel 5.3.2 as it does not have EFI_RCI2_TABLE option
and generated a .config by calling 'make defconfig'. The .config has
COMPILE_TEST set to n. I copied it to 5.4-rc1 and added 'depends on COMPILE=
_TEST'=20
to drivers/firmware/efi/Kconfig (did not add CONFIG_X86 because it is
set to y by the defconfig from 5.3.2). 'make oldconfig' still provides a
prompt for CONFIG_EFI_RCI2_TABLE.=20

I removed 'depends on COMPILE_TEST' from Kconfig and modified it to
include the below change -


config EFI_RCI2_TABLE
	bool=20
	prompt "EFI Runtime Configuration Interface Table Version 2 Support" if CO=
MPILE_TEST
	default n
	help

Adding the condition to the 'prompt' section seems to have desired
result. With this change, 'make oldconfig' did not provide a prompt.=20

It seems like 'make oldconfig' will provide a prompt to the user if the
CONFIG option is new and providing the prompt does not depend on the
'depends on' section. It seems to be dependent on the 'prompt' section.

Any thoughts ? If the above understanding is correct, I will work to
submit a patch with 'prompt' section modified to contain

prompt "EFI Runtime Configuration Interface Table Version 2 Support" if X86=
 || COMPILE_TEST

--=20
With regards,
Narendra K=
