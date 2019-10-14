Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 28998D5F60
	for <lists+linux-efi@lfdr.de>; Mon, 14 Oct 2019 11:51:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730677AbfJNJve (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 14 Oct 2019 05:51:34 -0400
Received: from mx0b-00154904.pphosted.com ([148.163.137.20]:17294 "EHLO
        mx0b-00154904.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731166AbfJNJve (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 14 Oct 2019 05:51:34 -0400
Received: from pps.filterd (m0170395.ppops.net [127.0.0.1])
        by mx0b-00154904.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x9E9ocVs005938;
        Mon, 14 Oct 2019 05:51:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=smtpout1;
 bh=A9pzisXF04DHMuIzASCBzW74pVCT2sixQNkp4UFLJGc=;
 b=i9GFdU88oWMHX6qt+1tzU7RauZLzOD7j15N09xU1tpX3EeXCM8/kAyknEoJPQnz9RQv8
 CcSninocD49tk+f40ENVU4oK6f2T5LM7tWrUiBtc6j7YRH54mxHP8O+s1dbn2zAk0Zt0
 HY8Ca6TrVPh+APVIVndIDJbqb2jruowGC40VzDNo+fGeWrvEzgHuixuXxTKunT8cQFGU
 p3bjXhYQwpJFuG4QQK0fSerMlokiw6b/q0dh0E2xXiccvPKxAyAsXDG2y2pGghYK3bRA
 qTRdmGml3RYOab6weiKPWcOHIwE/kzo4I3UzLhpcYA1kdlf0IHwulL9XgVIdg8udKh4f qQ== 
Received: from mx0b-00154901.pphosted.com (mx0b-00154901.pphosted.com [67.231.157.37])
        by mx0b-00154904.pphosted.com with ESMTP id 2vkbgqf2tv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 14 Oct 2019 05:51:32 -0400
Received: from pps.filterd (m0089483.ppops.net [127.0.0.1])
        by mx0b-00154901.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x9E9luVt117112;
        Mon, 14 Oct 2019 05:51:31 -0400
Received: from ausxipps306.us.dell.com (AUSXIPPS306.us.dell.com [143.166.148.156])
        by mx0b-00154901.pphosted.com with ESMTP id 2vm4a1at0v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 14 Oct 2019 05:51:31 -0400
X-LoopCount0: from 10.166.132.134
X-PREM-Routing: D-Outbound
X-IronPort-AV: E=Sophos;i="5.60,349,1549951200"; 
   d="scan'208";a="388301078"
From:   <Narendra.K@dell.com>
To:     <ard.biesheuvel@linaro.org>
CC:     <geert@linux-m68k.org>, <linux-efi@vger.kernel.org>,
        <Mario.Limonciello@dell.com>, <mingo@kernel.org>,
        <tglx@linutronix.de>, <james.morse@arm.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1] Ask user input only when CONFIG_X86 or
 CONFIG_COMPILE_TEST is set to y
Thread-Topic: [PATCH v1] Ask user input only when CONFIG_X86 or
 CONFIG_COMPILE_TEST is set to y
Thread-Index: AQHVgfgBvGXu4mhWM0KINjBW7iNITKdZVJcAgAACbYCAADKugA==
Date:   Mon, 14 Oct 2019 09:51:25 +0000
Message-ID: <20191014095115.GA2203@localhost.localdomain>
References: <20191013185643.GA2583@localhost.localdomain>
 <CAMuHMdVa_UaaKEf5sSDs+8AWJL7=X5JVPWuW23qtWqK9fpEecA@mail.gmail.com>
 <CAKv+Gu-aOHbdG2T9fPp7S4PvRAVosnsnCdsdHEk5PHnSN4gBrQ@mail.gmail.com>
In-Reply-To: <CAKv+Gu-aOHbdG2T9fPp7S4PvRAVosnsnCdsdHEk5PHnSN4gBrQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mutt/1.10.1 (2018-07-13)
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.143.242.75]
Content-Type: text/plain; charset="us-ascii"
Content-ID: <941AE1343A804141BE85CF329DF70E0D@dell.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-10-14_06:2019-10-10,2019-10-14 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 bulkscore=0
 spamscore=0 lowpriorityscore=0 mlxlogscore=999 adultscore=0
 impostorscore=0 malwarescore=0 clxscore=1015 priorityscore=1501
 suspectscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-1908290000 definitions=main-1910140095
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 lowpriorityscore=0
 malwarescore=0 suspectscore=0 bulkscore=0 adultscore=0 spamscore=0
 clxscore=1015 impostorscore=0 phishscore=0 mlxlogscore=999 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-1908290000
 definitions=main-1910140095
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Mon, Oct 14, 2019 at 08:49:51AM +0200, Ard Biesheuvel wrote:
>=20
> [EXTERNAL EMAIL]=20
>=20
> On Mon, 14 Oct 2019 at 08:41, Geert Uytterhoeven <geert@linux-m68k.org> w=
rote:
> >
> > Hi Narendra,
> >
> > On Sun, Oct 13, 2019 at 8:57 PM <Narendra.K@dell.com> wrote:
> > > From: Narendra K <Narendra.K@dell.com>
> > >
> > > For the EFI_RCI2_TABLE kconfig option, 'make oldconfig' asks the user
> > > for input on platforms where the option may not be applicable. This p=
atch
> > > modifies the kconfig option to ask the user for input only when CONFI=
G_X86
> > > or CONFIG_COMPILE_TEST is set to y.
> > >
> > > Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
> > > Fix-suggested-by: Geert Uytterhoeven <geert@linux-m68k.org>
> >
> > Suggested-by: ...?
> >
>=20
> Indeed

Hi Ard/Geert,

Thank you for correcting this. Should the patch be resubmitted with
the above change made ?

>=20
> > > Signed-off-by: Narendra K <Narendra.K@dell.com>
> >
> > Thanks for your patch!
> >
> > Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>
> >
>=20
> Thanks all. I'll get this queued as a fix.

Thank you for review comments.
--=20
With regards,
Narendra K=
