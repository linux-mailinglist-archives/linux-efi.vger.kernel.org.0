Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 98BAED2FC2
	for <lists+linux-efi@lfdr.de>; Thu, 10 Oct 2019 19:47:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726182AbfJJRrm (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 10 Oct 2019 13:47:42 -0400
Received: from mx0b-00154904.pphosted.com ([148.163.137.20]:33892 "EHLO
        mx0b-00154904.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726091AbfJJRrm (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 10 Oct 2019 13:47:42 -0400
Received: from pps.filterd (m0170397.ppops.net [127.0.0.1])
        by mx0b-00154904.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x9AHZd5Y007859;
        Thu, 10 Oct 2019 13:47:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=smtpout1;
 bh=L5GXx3mox0EzVbNJGhVgnlBj3HadmPIkaxN59aZroN4=;
 b=LK3c4rVQkg3CJXSFZZxvhAyiBoT0FHlcOxrKUXhSlFfVE0B8Q3UCdPlz2vLBgsAwfo6Q
 DdWAsDrvwB+JKss4T9iLAgaApwIZpEhns1LLYBEnTJ7gfXHqqFB4VUtU63IsPjJ4uelV
 iVIHmsstcUxEtbGpdUR93VFglQ6Vt7OQVRdbAWRqWlwkSCmgT7Tw4v2vgIIe2NGbIJ34
 MvfGSo1uzUXloODPAKItCljn+xqbLk4jkWsLfA2JHOhHAzyg+ALet3V2Z+TrZmD33w9U
 ODMS7YH9bHjKyeAi5CCqKE6LLRlusP2WYKZ4XbUzbq6B1dTU8ysbO+eQpTPzF47xEaeX MQ== 
Received: from mx0a-00154901.pphosted.com (mx0a-00154901.pphosted.com [67.231.149.39])
        by mx0b-00154904.pphosted.com with ESMTP id 2vj8kwg8hy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 10 Oct 2019 13:47:37 -0400
Received: from pps.filterd (m0142699.ppops.net [127.0.0.1])
        by mx0a-00154901.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x9AHcUBp028792;
        Thu, 10 Oct 2019 13:47:36 -0400
Received: from ausxippc106.us.dell.com (AUSXIPPC106.us.dell.com [143.166.85.156])
        by mx0a-00154901.pphosted.com with ESMTP id 2vj7m7t5m8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 10 Oct 2019 13:47:36 -0400
X-LoopCount0: from 10.166.132.133
X-PREM-Routing: D-Outbound
X-IronPort-AV: E=Sophos;i="5.60,349,1549951200"; 
   d="scan'208";a="472812424"
From:   <Narendra.K@dell.com>
To:     <ard.biesheuvel@linaro.org>
CC:     <linux-efi@vger.kernel.org>, <Mario.Limonciello@dell.com>,
        <geert@linux-m68k.org>, <tglx@linutronix.de>,
        <linux-kernel@vger.kernel.org>, <james.morse@arm.com>,
        <mingo@kernel.org>
Subject: Re: [PATCH] Ask user input only when CONFIG_X86 or
 CONFIG_COMPILE_TEST is set to y
Thread-Topic: [PATCH] Ask user input only when CONFIG_X86 or
 CONFIG_COMPILE_TEST is set to y
Thread-Index: AQHVeVm8hd3/NfhPNEW1ErxPMn2a1adSB94AgAHOtgA=
Date:   Thu, 10 Oct 2019 17:47:30 +0000
Message-ID: <20191010174710.GA2405@localhost.localdomain>
References: <20191002194346.GA3792@localhost.localdomain>
 <CAKv+Gu9_xX3RgDNGB=T83vhg_snMKe0F2YPKp1S2o2toNHHZZQ@mail.gmail.com>
In-Reply-To: <CAKv+Gu9_xX3RgDNGB=T83vhg_snMKe0F2YPKp1S2o2toNHHZZQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mutt/1.10.1 (2018-07-13)
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.143.242.75]
Content-Type: text/plain; charset="us-ascii"
Content-ID: <CDDA16D306AADF4A96E170322B65887B@dell.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-10-10_06:2019-10-10,2019-10-10 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0 mlxscore=0
 suspectscore=0 bulkscore=0 phishscore=0 mlxlogscore=999 priorityscore=1501
 adultscore=0 clxscore=1015 malwarescore=0 spamscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-1908290000
 definitions=main-1910100155
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 impostorscore=0
 suspectscore=0 phishscore=0 priorityscore=1501 bulkscore=0 mlxscore=0
 malwarescore=0 adultscore=0 spamscore=0 mlxlogscore=999 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-1908290000
 definitions=main-1910100155
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hi Ard,

Thank you for the review comments.=20

On Wed, Oct 09, 2019 at 04:11:04PM +0200, Ard Biesheuvel wrote:
> On Wed, 2 Oct 2019 at 21:44, <Narendra.K@dell.com> wrote:
> >
> > From: Narendra K <Narendra.K@dell.com>
> >
> > For the EFI_RCI2_TABLE kconfig option, 'make oldconfig' asks the user
> > for input as it is a new kconfig option in kernel version 5.4. This pat=
ch
> > modifies the kconfig option to ask the user for input only when CONFIG_=
X86
> > or CONFIG_COMPILE_TEST is set to y.
> >
> > The patch also makes EFI_RCI2_TABLE kconfig option depend on CONFIG_EFI=
.
> >
> > Signed-off-by: Narendra K <Narendra.K@dell.com>
> > ---
> > The patch is created on kernel version 5.4-rc1.
> >
> > Hi Ard, I have made following changes -
> >
> > - changed the prompt string from "EFI Runtime Configuration
> > Interface Table Version 2 Support" to "EFI RCI Table Version 2 Support"
> > as the string crossed 80 char limit.
> >
> > - added "depends on EFI" so that code builds only when CONFIG_EFI is
> > set to y.
> >
> > - added 'default n' for ease of understanding though default is set to =
n.
> >
>=20
> None of these changes are necessary, tbh. 'depends on EFI' is implied
> by the placement of the option, and default n is indeed the default.

I will drop the changes in the next version of the patch.

>=20
>=20
> >  drivers/firmware/efi/Kconfig | 5 ++++-
> >  1 file changed, 4 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/firmware/efi/Kconfig b/drivers/firmware/efi/Kconfi=
g
> > index 178ee8106828..6e4c46e8a954 100644
> > --- a/drivers/firmware/efi/Kconfig
> > +++ b/drivers/firmware/efi/Kconfig
> > @@ -181,7 +181,10 @@ config RESET_ATTACK_MITIGATION
> >           reboots.
> >
> >  config EFI_RCI2_TABLE
> > -       bool "EFI Runtime Configuration Interface Table Version 2 Suppo=
rt"
> > +       bool
> > +       prompt "EFI RCI Table Version 2 Support" if X86 || COMPILE_TEST
>=20
> You can drop the || COMPILE_TEST as well.

I will drop this part of the change in the next version of the patch.=20

--=20
With regards,
Narendra K=
