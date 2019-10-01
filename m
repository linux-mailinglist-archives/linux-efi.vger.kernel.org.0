Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 94CC7C3F3D
	for <lists+linux-efi@lfdr.de>; Tue,  1 Oct 2019 20:02:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731213AbfJASB7 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 1 Oct 2019 14:01:59 -0400
Received: from mx0b-00154904.pphosted.com ([148.163.137.20]:41162 "EHLO
        mx0b-00154904.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725844AbfJASB7 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 1 Oct 2019 14:01:59 -0400
Received: from pps.filterd (m0170396.ppops.net [127.0.0.1])
        by mx0b-00154904.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x91I0chP018711;
        Tue, 1 Oct 2019 14:01:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=smtpout1;
 bh=3IDhzMT3O06G6cUdSpSungeN982mOo7wmjN+eOZAo4A=;
 b=m32COeGWSwew8NwB4vskWcpyqKkut52taa9kRlkViz9NW7WMliT0AbaD/8UNNsTX1zJL
 1Vt82ZrkgeA6ln3fXSLF/uw/AFH3ip2R4Kdpy/ChIleifbo94zMBpGR8HFxN53XSe5MJ
 GIXZIsqsJikkc+PPKVpPbnczb8UPDzJz/2S2i5VIqWgEZ7/pE+zXkw6HLhcGiEw4D2+z
 BpCK+95lg7nCrrjxS8usAGCIab2B8sQN2kiV8gJ01f3vWGoLPo5ZRvF/PaMprs7ffz7Y
 Pi3OoM/7xUp8+icnQbfU5z8OrqJYHfajQTD6kJkvEfSlDi95QoW8+zFEgLV9xZq4aSAq yQ== 
Received: from mx0a-00154901.pphosted.com (mx0b-00154901.pphosted.com [67.231.157.37])
        by mx0b-00154904.pphosted.com with ESMTP id 2va3byxrv7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 01 Oct 2019 14:01:56 -0400
Received: from pps.filterd (m0089484.ppops.net [127.0.0.1])
        by mx0b-00154901.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x91Hvw42117812;
        Tue, 1 Oct 2019 14:01:55 -0400
Received: from ausc60pc101.us.dell.com (ausc60pc101.us.dell.com [143.166.85.206])
        by mx0b-00154901.pphosted.com with ESMTP id 2vc0wmvf18-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 01 Oct 2019 14:01:53 -0400
X-LoopCount0: from 10.166.134.83
X-PREM-Routing: D-Outbound
X-IronPort-AV: E=Sophos;i="5.60,349,1549951200"; 
   d="scan'208";a="1473278184"
From:   <Narendra.K@dell.com>
To:     <Mario.Limonciello@dell.com>
CC:     <ard.biesheuvel@linaro.org>, <geert@linux-m68k.org>,
        <Narendra.K@dell.com>, <linux-efi@vger.kernel.org>,
        <mingo@kernel.org>, <tglx@linutronix.de>,
        <linux-kernel@vger.kernel.org>, <james.morse@arm.com>,
        <tanxiaofei@huawei.com>
Subject: Re: [PATCH 4/5] efi: Export Runtime Configuration Interface table to
 sysfs
Thread-Topic: [PATCH 4/5] efi: Export Runtime Configuration Interface table to
 sysfs
Thread-Index: AQHVUR9fTJBv0Z/1EU2zTW0DTQ5+k6dFbG6AgAAA2ACAAAKAgIAACpuAgAA9PgCAAE5zgA==
Date:   Tue, 1 Oct 2019 18:01:47 +0000
Message-ID: <20191001180133.GA2279@localhost.localdomain>
References: <20190812150452.27983-1-ard.biesheuvel@linaro.org>
 <20190812150452.27983-5-ard.biesheuvel@linaro.org>
 <CAMuHMdXY5UH4KhcaNVuxa8-+GN-4bjyvCd0wzPYuFBY5Ch=fNA@mail.gmail.com>
 <CAKv+Gu-KPypju6roQaVKP0DHE3aZijVVqLGwNyhiRSNqn1r6-w@mail.gmail.com>
 <CAMuHMdV9m+Dbch46cVNqtn4cyB74qgHa18Qcm=HQv7Wx1rk==w@mail.gmail.com>
 <CAKv+Gu9iLxkJgmxZR+1yvCTj6GiCDuyfN_QiGXEWBHS7uYUbfQ@mail.gmail.com>
 <8446d19dd197447a88eed580601f3c4c@AUSX13MPC105.AMER.DELL.COM>
In-Reply-To: <8446d19dd197447a88eed580601f3c4c@AUSX13MPC105.AMER.DELL.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mutt/1.10.1 (2018-07-13)
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.143.242.75]
Content-Type: text/plain; charset="us-ascii"
Content-ID: <B3B522C075A76440ABEBBE764F1859B9@dell.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-10-01_08:2019-10-01,2019-10-01 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 lowpriorityscore=0 impostorscore=0 suspectscore=0 spamscore=0
 mlxlogscore=999 bulkscore=0 mlxscore=0 priorityscore=1501 adultscore=0
 clxscore=1011 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1908290000 definitions=main-1910010146
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 bulkscore=0 lowpriorityscore=0 phishscore=0 suspectscore=0 impostorscore=0
 mlxscore=0 priorityscore=1501 adultscore=0 clxscore=1011 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-1908290000
 definitions=main-1910010146
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue, Oct 01, 2019 at 01:20:46PM +0000, Limonciello, Mario wrote:
[...]
> > > > > > +config EFI_RCI2_TABLE
> > > > > > +       bool "EFI Runtime Configuration Interface Table Version=
 2 Support"
> > > > > > +       help
> > > > > > +         Displays the content of the Runtime Configuration Int=
erface
> > > > > > +         Table version 2 on Dell EMC PowerEdge systems as a bi=
nary
> > > > > > +         attribute 'rci2' under /sys/firmware/efi/tables direc=
tory.
> > > > > > +
> > > > > > +         RCI2 table contains BIOS HII in XML format and is use=
d to populate
> > > > > > +         BIOS setup page in Dell EMC OpenManage Server Adminis=
trator tool.
> > > > > > +         The BIOS setup page contains BIOS tokens which can be=
 configured.
> > > > > > +
> > > > > > +         Say Y here for Dell EMC PowerEdge systems.
> > > > >
> > > > > A quick Google search tells me these are Intel Xeon.
> > > > > Are arm/arm64/ia64 variants available, too?
> > > > > If not, this should be protected by "depends on x86" ("|| COMPILE=
_TEST"?).
> > > >
> > > > The code in question is entirely architecture agnostic, and default=
s
> > > > to 'n', so I am not convinced this is needed. (It came up in the
> > > > review as well)
> > >
> > > "make oldconfig" still asks me the question on e.g. arm64, where it i=
s
> > > irrelevant, until arm64 variants of the hardware show up.
> > >
> > > So IMHO it should have "depends on X86 || COMPILE_TEST".
> > >
> >=20
> > Fair enough. I am going to send out a bunch of EFI fixes this week, so
> > I'll accept a patch that makes the change above.
>=20
> Is it really a problem to just say n?
>=20
> I think this seems like a needless change that would slow down adoption o=
f
> !x86 if Dell EMC PowerEdge systems did start going that route, especially
> when it comes to distributions that move glacially slow with picking up n=
ew
> kernel code.

Hi Ard/Geert,

Any additional thoughts here ?

--=20
With regards,
Narendra K=
