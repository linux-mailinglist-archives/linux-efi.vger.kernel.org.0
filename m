Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B2C41123B4
	for <lists+linux-efi@lfdr.de>; Thu,  2 May 2019 22:56:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726363AbfEBU4k (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 2 May 2019 16:56:40 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:35846 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726326AbfEBU4k (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 2 May 2019 16:56:40 -0400
Received: by mail-io1-f67.google.com with SMTP id d19so3481128ioc.3
        for <linux-efi@vger.kernel.org>; Thu, 02 May 2019 13:56:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=W3LPddwCKGY2xDs2u/DUWFbBGqANYJTYynM8oS/U41s=;
        b=KgC8Txd4sqFpfNVIU5Wc0c0htULB4U6DQmgHOL62Lo4Qhb7H8HeoP6A5oyBRfRlIxH
         nbujZgFqKo77czxlk/kYHMvFORPVv3giYwy/vyNp+e5oH4IrW1KDEJN1DWBhUNtI7QWi
         Jud+60EOp+yWaRfrdV/xm2B2vgIN4UsTjluESbASHsPOg2gqqxpsMYXqfKwILZWxH4Qf
         xY8RD73W6/ytjIAP8KEyoS53A04zKtk6p1VGqlaftgWj7DFwAErc2E/gr9bz3vf8H1Ae
         y3fHfE6gJdC97GBgVgLqfluYDtX+PSbeRDTlYIaOf3VAmN5x9tJYBIkgwJ8kvCLdXigZ
         Rhkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=W3LPddwCKGY2xDs2u/DUWFbBGqANYJTYynM8oS/U41s=;
        b=La54vrX6nRJstcbS89pddSvuHbOzKNulKw4jZUDEhqCAyEgnKJnF6hsD629jEgSQ9r
         Qv+K7l2bvhIVneavq05zjxPgyrs1pOOI1Deu3g75CdXHB8T+p2kqsKqUdUaDer9j0zGt
         2IZ/XwezMnCNu8hCQfvSvq5Hmb0oM5T1sPcyz2H9Sk+3m9vchUH8rl2spCKRbywucpLS
         Pag4NgntNxSj/M4LBmndsFlqZ4/iqZ3D7piUZOdfvIZWLPmg1rWFbVoFdARaic2z0B7H
         I2SFsbzm5Al/MwCAhCA/yLuehBACPZF41OFdC68pyhWtHwFkWLeU5RDyJ1YaK/9dfpHt
         0Ljg==
X-Gm-Message-State: APjAAAVGkHGOKbqcOiTF0l3Wl0SRzNUHcagPi8f6CmVaa43MEz63WWee
        AdnfPUOF4PGvCMHaRWxN/Fp73qQN83NlLDtMeERcBg==
X-Google-Smtp-Source: APXvYqw8fJr5vPiI/5b4rrryNsL0YNv88XUlTZMDz7MCDm+On7B/QMbwAD7N2VgsEzqDAu88wY0gE9GedHWaSxSS7n4=
X-Received: by 2002:a6b:7b47:: with SMTP id m7mr4208092iop.173.1556830599457;
 Thu, 02 May 2019 13:56:39 -0700 (PDT)
MIME-Version: 1.0
References: <20190227202658.197113-1-matthewgarrett@google.com>
 <20190227202658.197113-3-matthewgarrett@google.com> <CAJzaN5pUJoOCz5-ZDSnTb6dbVPuy0QwmFD0CeofAGK+bRQx0og@mail.gmail.com>
 <CACdnJutpBPAX6TOGgs3Ng2v_cC5hAf-3pHThESvjQ9vbvQeVkA@mail.gmail.com>
 <CAKv+Gu9PF4u=-7QL4e36Q3S5kC4+5Z=yLYHLT9jE+eNY7YUV7A@mail.gmail.com> <CACdnJuvDuw0X9iwEqOu7EjM5ca1f+n7f=xqzrTPS9PyrmqKNHQ@mail.gmail.com>
In-Reply-To: <CACdnJuvDuw0X9iwEqOu7EjM5ca1f+n7f=xqzrTPS9PyrmqKNHQ@mail.gmail.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Thu, 2 May 2019 22:56:27 +0200
Message-ID: <CAKv+Gu9GpmK7-kb2GJuhrL2Qau7ebqDdy4-LdwFDmPz-Os0quw@mail.gmail.com>
Subject: Re: [PATCH V5 2/4] tpm: Reserve the TPM final events table
To:     Matthew Garrett <mjg59@google.com>
Cc:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Ingo Molnar <mingo@kernel.org>,
        Bartosz Szczepanek <bsz@semihalf.com>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Roberto Sassu <roberto.sassu@huawei.com>,
        linux-efi <linux-efi@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        =?UTF-8?Q?Thi=C3=A9baud_Weksteen?= <tweek@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, 2 May 2019 at 20:04, Matthew Garrett <mjg59@google.com> wrote:
>
> On Thu, May 2, 2019 at 12:15 AM Ard Biesheuvel
> <ard.biesheuvel@linaro.org> wrote:
> >
> > (+ Ingo)
> >
> > On Tue, 30 Apr 2019 at 21:52, Matthew Garrett <mjg59@google.com> wrote:
> > >
> > > On Tue, Apr 30, 2019 at 6:07 AM Bartosz Szczepanek <bsz@semihalf.com> wrote:
> > > >
> > > > I may be a little late with this comment, but I've just tested these
> > > > patches on aarch64 platform (from the top of jjs/master) and got
> > > > kernel panic ("Unable to handle kernel read", full log at the end of
> > > > mail). I think there's problem with below call to
> > > > tpm2_calc_event_log_size(), where physical address of efi.tpm_log is
> > > > passed as (void *) and never remapped:
> > >
> > > Yes, it looks like this is just broken. Can you try with the attached patch?
> >
> > I'm a bit uncomfortable with EFI code that is obviously broken and
> > untested being queued for the next merge window in another tree.
>
> The patchset was Cc:ed to linux-efi@. Is there anything else I should
> have done to ensure you picked it up rather than Jarkko?

No, I am not saying it was you who did anything wrong - Jarkko and I
should probably have aligned better. But my own testing wouldn't have
caught this particular issue either (I am still in the process of
getting access to ARM machines with a TPM), so it wouldn't have made a
huge difference in any case.
