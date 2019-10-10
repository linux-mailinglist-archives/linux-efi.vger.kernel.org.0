Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DE3CBD26A0
	for <lists+linux-efi@lfdr.de>; Thu, 10 Oct 2019 11:48:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733257AbfJJJs3 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 10 Oct 2019 05:48:29 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:54030 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725901AbfJJJs3 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 10 Oct 2019 05:48:29 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9A9htUu184427;
        Thu, 10 Oct 2019 09:47:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=HWgDA3usn6LIiHd+pkq34eP7DWLFpFV868jyT595gos=;
 b=J4OskXRbJ9YmGjse57CZuMTMLVj7FBSMl8RrxK4D6nmkb4q+M68EKYB6uY7gtYm0NigD
 +YE3320PDCFYNGjmAc6LmtZ4+hKttvSTTIRYMwwueoYpxDzVPCUx8PgMTg3TElc5mu56
 DKN9Gnx9GqolaCvacE3+ih09uPUMNw6S69KBsdEKGOveEQzKD9gneVQ0xI+WAXx7UbO8
 d7Lo8MnyEDfggZxWkMnEZMyxuC7y324y6CdUBJTxmhqzLZc3ykB80zU85gp5uin36G0B
 NA7cY1XHZwYdTUDPjp5sKB6UFUu4BQYUqA87BujVLMQ+j5Ww+UzNYbp86FG/9JgOJxPG Yg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 2vek4qt0hs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 10 Oct 2019 09:47:56 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9A9hESJ162338;
        Thu, 10 Oct 2019 09:47:56 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3020.oracle.com with ESMTP id 2vh5ccu4ec-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 10 Oct 2019 09:47:55 +0000
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x9A9lpL5004016;
        Thu, 10 Oct 2019 09:47:51 GMT
Received: from tomti.i.net-space.pl (/10.175.215.43)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 10 Oct 2019 02:47:50 -0700
Date:   Thu, 10 Oct 2019 11:43:49 +0200
From:   Daniel Kiper <daniel.kiper@oracle.com>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
        x86@kernel.org, xen-devel@lists.xenproject.org,
        ard.biesheuvel@linaro.org, boris.ostrovsky@oracle.com,
        bp@alien8.de, corbet@lwn.net, dave.hansen@linux.intel.com,
        luto@kernel.org, peterz@infradead.org, eric.snowberg@oracle.com,
        hpa@zytor.com, jgross@suse.com, konrad.wilk@oracle.com,
        mingo@redhat.com, ross.philipson@oracle.com, tglx@linutronix.de
Subject: Re: [PATCH v3 1/3] x86/boot: Introduce the kernel_info
Message-ID: <20191010094349.la3sjiuiikmegjck@tomti.i.net-space.pl>
References: <20191009105358.32256-1-daniel.kiper@oracle.com>
 <20191009105358.32256-2-daniel.kiper@oracle.com>
 <181249b6-5833-6f29-7d38-6dacc3f8ee62@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <181249b6-5833-6f29-7d38-6dacc3f8ee62@infradead.org>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9405 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1910100087
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9405 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1910100087
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, Oct 09, 2019 at 05:43:31PM -0700, Randy Dunlap wrote:
> Hi,
>
> Questions and comments below...
> Thanks.
>
> On 10/9/19 3:53 AM, Daniel Kiper wrote:
>
> > Suggested-by: H. Peter Anvin <hpa@zytor.com>
> > Signed-off-by: Daniel Kiper <daniel.kiper@oracle.com>
> > Reviewed-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
> > Reviewed-by: Ross Philipson <ross.philipson@oracle.com>
> > ---
>
> > ---
> >  Documentation/x86/boot.rst             | 121 +++++++++++++++++++++++++++++++++
> >  arch/x86/boot/Makefile                 |   2 +-
> >  arch/x86/boot/compressed/Makefile      |   4 +-
> >  arch/x86/boot/compressed/kernel_info.S |  17 +++++
> >  arch/x86/boot/header.S                 |   1 +
> >  arch/x86/boot/tools/build.c            |   5 ++
> >  arch/x86/include/uapi/asm/bootparam.h  |   1 +
> >  7 files changed, 148 insertions(+), 3 deletions(-)
> >  create mode 100644 arch/x86/boot/compressed/kernel_info.S
> >
> > diff --git a/Documentation/x86/boot.rst b/Documentation/x86/boot.rst
> > index 08a2f100c0e6..d5323a39f5e3 100644
> > --- a/Documentation/x86/boot.rst
> > +++ b/Documentation/x86/boot.rst
> > @@ -68,8 +68,25 @@ Protocol 2.12	(Kernel 3.8) Added the xloadflags field and extension fields
> >  Protocol 2.13	(Kernel 3.14) Support 32- and 64-bit flags being set in
> >  		xloadflags to support booting a 64-bit kernel from 32-bit
> >  		EFI
> > +
> > +Protocol 2.14:	BURNT BY INCORRECT COMMIT ae7e1238e68f2a472a125673ab506d49158c1889
> > +		(x86/boot: Add ACPI RSDP address to setup_header)
> > +		DO NOT USE!!! ASSUME SAME AS 2.13.
> > +
> > +Protocol 2.15:	(Kernel 5.5) Added the kernel_info.
> >  =============	============================================================
> >
> > +.. note::
> > +     The protocol version number should be changed only if the setup header
> > +     is changed. There is no need to update the version number if boot_params
> > +     or kernel_info are changed. Additionally, it is recommended to use
> > +     xloadflags (in this case the protocol version number should not be
> > +     updated either) or kernel_info to communicate supported Linux kernel
> > +     features to the boot loader. Due to very limited space available in
> > +     the original setup header every update to it should be considered
> > +     with great care. Starting from the protocol 2.15 the primary way to
> > +     communicate things to the boot loader is the kernel_info.
> > +
> >
> >  Memory Layout
> >  =============
> > @@ -207,6 +224,7 @@ Offset/Size	Proto		Name			Meaning
> >  0258/8		2.10+		pref_address		Preferred loading address
> >  0260/4		2.10+		init_size		Linear memory required during initialization
> >  0264/4		2.11+		handover_offset		Offset of handover entry point
> > +0268/4		2.15+		kernel_info_offset	Offset of the kernel_info
> >  ===========	========	=====================	============================================
> >
> >  .. note::
> > @@ -855,6 +873,109 @@ Offset/size:	0x264/4
> >
> >    See EFI HANDOVER PROTOCOL below for more details.
> >
> > +============	==================
> > +Field name:	kernel_info_offset
> > +Type:		read
> > +Offset/size:	0x268/4
> > +Protocol:	2.15+
> > +============	==================
> > +
> > +  This field is the offset from the beginning of the kernel image to the
> > +  kernel_info. It is embedded in the Linux image in the uncompressed
>                   ^^
>    What does      It   refer to, please?

s/It/The kernel_info structure/ Is it better?

> > +  protected mode region.
> > +
> > +
> > +The kernel_info
> > +===============
> > +
> > +The relationships between the headers are analogous to the various data
> > +sections:
> > +
> > +  setup_header = .data
> > +  boot_params/setup_data = .bss
> > +
> > +What is missing from the above list? That's right:
> > +
> > +  kernel_info = .rodata
> > +
> > +We have been (ab)using .data for things that could go into .rodata or .bss for
> > +a long time, for lack of alternatives and -- especially early on -- inertia.
> > +Also, the BIOS stub is responsible for creating boot_params, so it isn't
> > +available to a BIOS-based loader (setup_data is, though).
> > +
> > +setup_header is permanently limited to 144 bytes due to the reach of the
> > +2-byte jump field, which doubles as a length field for the structure, combined
> > +with the size of the "hole" in struct boot_params that a protected-mode loader
> > +or the BIOS stub has to copy it into. It is currently 119 bytes long, which
> > +leaves us with 25 very precious bytes. This isn't something that can be fixed
> > +without revising the boot protocol entirely, breaking backwards compatibility.
> > +
> > +boot_params proper is limited to 4096 bytes, but can be arbitrarily extended
> > +by adding setup_data entries. It cannot be used to communicate properties of
> > +the kernel image, because it is .bss and has no image-provided content.
> > +
> > +kernel_info solves this by providing an extensible place for information about
> > +the kernel image. It is readonly, because the kernel cannot rely on a
> > +bootloader copying its contents anywhere, but that is OK; if it becomes
> > +necessary it can still contain data items that an enabled bootloader would be
> > +expected to copy into a setup_data chunk.
> > +
> > +All kernel_info data should be part of this structure. Fixed size data have to
> > +be put before kernel_info_var_len_data label. Variable size data have to be put
> > +behind kernel_info_var_len_data label. Each chunk of variable size data has to
>
>    s/behind/after/

OK.

> > +be prefixed with header/magic and its size, e.g.:
> > +
> > +  kernel_info:
> > +          .ascii  "LToP"          /* Header, Linux top (structure). */
> > +          .long   kernel_info_var_len_data - kernel_info
> > +          .long   kernel_info_end - kernel_info
> > +          .long   0x01234567      /* Some fixed size data for the bootloaders. */
> > +  kernel_info_var_len_data:
> > +  example_struct:                 /* Some variable size data for the bootloaders. */
> > +          .ascii  "EsTT"          /* Header/Magic. */
> > +          .long   example_struct_end - example_struct
> > +          .ascii  "Struct"
> > +          .long   0x89012345
> > +  example_struct_end:
> > +  example_strings:                /* Some variable size data for the bootloaders. */
> > +          .ascii  "EsTs"          /* Header/Magic. */
>
> Where do the Magic values "EsTT" and "EsTs" come from?
> where are they defined?

EsTT == Example STrucT
EsTs == Example STringS

Anyway, it can be anything which does not collide with existing variable
length data magics. There are none right now. So, it can be anything.
Maybe I should add something saying that.

Daniel
