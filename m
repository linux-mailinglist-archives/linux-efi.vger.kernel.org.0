Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F30131278C
	for <lists+linux-efi@lfdr.de>; Fri,  3 May 2019 08:15:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726182AbfECGPz (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 3 May 2019 02:15:55 -0400
Received: from smtp.nue.novell.com ([195.135.221.5]:56523 "EHLO
        smtp.nue.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726156AbfECGPy (ORCPT
        <rfc822;groupwise-linux-efi@vger.kernel.org:0:0>);
        Fri, 3 May 2019 02:15:54 -0400
Received: from emea4-mta.ukb.novell.com ([10.120.13.87])
        by smtp.nue.novell.com with ESMTP (TLS encrypted); Fri, 03 May 2019 08:15:52 +0200
Received: from linux-l9pv.suse (nwb-a10-snat.microfocus.com [10.120.13.202])
        by emea4-mta.ukb.novell.com with ESMTP (TLS encrypted); Fri, 03 May 2019 07:15:23 +0100
Date:   Fri, 3 May 2019 14:15:18 +0800
From:   joeyli <jlee@suse.com>
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     "Lee, Chun-Yi" <joeyli.kernel@gmail.com>,
        James Morris <jmorris@namei.org>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        David Howells <dhowells@redhat.com>,
        Josh Boyer <jwboyer@fedoraproject.org>,
        Nayna Jain <nayna@linux.ibm.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        linux-efi <linux-efi@vger.kernel.org>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>
Subject: Re: [PATCH 1/2 v2] efi: add a function to convert the status value
 to string
Message-ID: <20190503061518.GM11486@linux-l9pv.suse>
References: <20190502040441.30372-1-jlee@suse.com>
 <CAKv+Gu9mjtNEWN-w4ix7VJMZ_kk-Qf6FfYFRu2mCosaAjMA4Vg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKv+Gu9mjtNEWN-w4ix7VJMZ_kk-Qf6FfYFRu2mCosaAjMA4Vg@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, May 02, 2019 at 10:53:31AM +0200, Ard Biesheuvel wrote:
> On Thu, 2 May 2019 at 06:04, Lee, Chun-Yi <joeyli.kernel@gmail.com> wrote:
> >
> > This function can be used to convert EFI status value to string
> > for printing out debug message. Using this function can improve
> > the readability of log.
> >
> > v2.
> 
> Please move the changelog out of the commit log (move it below the ---
> further down)
>

OK! I will moved the changelog out of the commit log.
 
> > - Changed the wording in subject and description.
> > - Moved the marco immediately after the status value definitions.
> > - Turned into a proper function instead of inline.
> >
> 
> You missed my point here. A proper function means the function in a .c
> file, and only the declaration in a .h file. This way, you are still
> duplicating the literal strings into every object file that references
> this function.
>

Sorry for I missunderstood. I will move the function to load_uefi.c.

Thanks a lot!
Joey Lee
