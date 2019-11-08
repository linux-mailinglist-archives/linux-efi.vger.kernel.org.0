Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8CFB3F44EF
	for <lists+linux-efi@lfdr.de>; Fri,  8 Nov 2019 11:49:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727016AbfKHKtO (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 8 Nov 2019 05:49:14 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:46400 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726149AbfKHKtN (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 8 Nov 2019 05:49:13 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xA8AjGqi046403;
        Fri, 8 Nov 2019 10:47:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=kBevcn7bSITNRLFqXhWbTPcrt4smHMbslYxVx+6MMTU=;
 b=MAIfZ6eVxbW4QkaPitoy1W0MajRcHVkJNP3Z36YXxrAVfEubFE9cuhDFGGKWq1bpBvbj
 nWL78QajL8j42KbXqnsk5toA9wprVDmJ4JJ2hhB/10vuw+hP7MR5gCvLeZKvNEUarNbs
 0JlVoh7EBuHvR7pVSxRWpk9iCEd51jX1HwaPeZZEiKeBkchEeloe3NKrNQ31SFk3bhDJ
 S19teEm/EqM5+Z53rnthfFxvbWBkQVi5NmQxzpC6WEhE27GUKdqcDZAMBupFWYy8yTy1
 bvx7DT70HsH31DqZX3K1gSnmSCDmBVYz/FpbnsGR7XD4/pV0rpqOfbchMK8bWFqVq3o+ /g== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 2w41w14gy8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 08 Nov 2019 10:47:15 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xA8AgOOf193616;
        Fri, 8 Nov 2019 10:47:15 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3020.oracle.com with ESMTP id 2w4k31hjkq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 08 Nov 2019 10:47:15 +0000
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id xA8Al9vV008851;
        Fri, 8 Nov 2019 10:47:09 GMT
Received: from tomti.i.net-space.pl (/10.175.202.125)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 08 Nov 2019 02:47:09 -0800
Date:   Fri, 8 Nov 2019 11:47:02 +0100
From:   Daniel Kiper <daniel.kiper@oracle.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
        x86@kernel.org, xen-devel@lists.xenproject.org,
        ard.biesheuvel@linaro.org, boris.ostrovsky@oracle.com,
        corbet@lwn.net, dave.hansen@linux.intel.com, luto@kernel.org,
        peterz@infradead.org, eric.snowberg@oracle.com, hpa@zytor.com,
        jgross@suse.com, kanth.ghatraju@oracle.com, konrad.wilk@oracle.com,
        mingo@redhat.com, rdunlap@infradead.org, ross.philipson@oracle.com,
        tglx@linutronix.de
Subject: Re: [PATCH v5 2/3] x86/boot: Introduce the kernel_info.setup_type_max
Message-ID: <20191108104702.vwfmvehbeuza4j5w@tomti.i.net-space.pl>
References: <20191104151354.28145-1-daniel.kiper@oracle.com>
 <20191104151354.28145-3-daniel.kiper@oracle.com>
 <20191108100930.GA4503@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191108100930.GA4503@zn.tnic>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9434 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1910280000 definitions=main-1911080104
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9434 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1910280000
 definitions=main-1911080105
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, Nov 08, 2019 at 11:09:30AM +0100, Borislav Petkov wrote:
> On Mon, Nov 04, 2019 at 04:13:53PM +0100, Daniel Kiper wrote:
> > This field contains maximal allowed type for setup_data.
> >
> > This patch does not bump setup_header version in arch/x86/boot/header.S
> > because it will be followed by additional changes coming into the
> > Linux/x86 boot protocol.
> >
> > Suggested-by: H. Peter Anvin (Intel) <hpa@zytor.com>
> > Signed-off-by: Daniel Kiper <daniel.kiper@oracle.com>
> > Reviewed-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
> > Reviewed-by: Ross Philipson <ross.philipson@oracle.com>
> > Reviewed-by: H. Peter Anvin (Intel) <hpa@zytor.com>
> > ---
> > v5 - suggestions/fixes:
> >    - move incorrect references to the setup_indirect to the
> >      patch introducing it,
> >    - do not bump setup_header version in arch/x86/boot/header.S
> >      (suggested by H. Peter Anvin).
> > ---
> >  Documentation/x86/boot.rst             | 9 ++++++++-
> >  arch/x86/boot/compressed/kernel_info.S | 5 +++++
> >  arch/x86/include/uapi/asm/bootparam.h  | 3 +++
> >  3 files changed, 16 insertions(+), 1 deletion(-)
> >
> > diff --git a/Documentation/x86/boot.rst b/Documentation/x86/boot.rst
> > index c60fafda9427..1dad6eee8a5c 100644
> > --- a/Documentation/x86/boot.rst
> > +++ b/Documentation/x86/boot.rst
> > @@ -73,7 +73,7 @@ Protocol 2.14:	BURNT BY INCORRECT COMMIT ae7e1238e68f2a472a125673ab506d49158c188
> >  		(x86/boot: Add ACPI RSDP address to setup_header)
> >  		DO NOT USE!!! ASSUME SAME AS 2.13.
> >
> > -Protocol 2.15:	(Kernel 5.5) Added the kernel_info.
> > +Protocol 2.15:	(Kernel 5.5) Added the kernel_info and kernel_info.setup_type_max.
> >  =============	============================================================
> >
> >  .. note::
> > @@ -981,6 +981,13 @@ Offset/size:	0x0008/4
> >    This field contains the size of the kernel_info including kernel_info.header
> >    and kernel_info.kernel_info_var_len_data.
> >
> > +============	==============
> > +Field name:	setup_type_max
> > +Offset/size:	0x0008/4
>
> You already have
>
> Field name:     size_total
> Offset/size:    0x0008/4
>
> at that offset.
>
> I guess you mean setup_type_max's offset to be 0x000c and it would be
> that member:
>
> .long   0x01234567      /* Some fixed size data for the bootloaders. */
>
> ?

Yeah, you are right. Would you like me to repost whole patch series or
could you fix it before committing?

Daniel
