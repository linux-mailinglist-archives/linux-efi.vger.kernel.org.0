Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ADEDA4C3D9
	for <lists+linux-efi@lfdr.de>; Thu, 20 Jun 2019 00:48:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726496AbfFSWsg (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 19 Jun 2019 18:48:36 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:44235 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726251AbfFSWsg (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 19 Jun 2019 18:48:36 -0400
Received: by mail-io1-f68.google.com with SMTP id s7so322414iob.11
        for <linux-efi@vger.kernel.org>; Wed, 19 Jun 2019 15:48:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=YKJaoMjaF4vCZqPi8dwckcEgHtOWdNYvU090tpibj0w=;
        b=d6WWNTDf8BwpcDeLK3CHrloIi8s3+6D20pkxtkx0tfHOzYzHxUI6l1c1+/LNMs30sM
         BMoSj2tz2++N/8yJG1frilcp+5jbpEvCMOhUNiSdjIaB9yxbr+UO33vHSgypay0UfOhi
         Akil9xVSqel1xTCQ4z11nvl3JpSCjY2nZZtKPRabomxyQWdVOczgB+u+evqwqvTekzlT
         7CcmYKsjG5BewmhtbtVRS1jKryf4TZHc8v0FmbPQ9rAXmEuK8zjbvTCi+lB6n2kUt45z
         0I6TQbCHrUNoR5C3o5YvtxgW4P36jHKWnGvCb01DQFWtUWUI/YyQyNWXVuYoliIbAWgw
         8zEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=YKJaoMjaF4vCZqPi8dwckcEgHtOWdNYvU090tpibj0w=;
        b=nfJ0KczSiKpWOrtymiY4IpDTOxdmAChjDnMSjcjmMXopuGHIOmSs36Q8L7fsaSm5hd
         vSa2wCvKzw7SMAbD4ASRQyfowKrWMMKZRLUYum4rqjbxZF3C/WNzUmJt28r7ENcNRpS9
         P0O/XlCCCvkJAZjp3hwxw1AMRU+GevHcyzx6jSFEoPQgSDNgLRbFNoeKorK9B7D/13rS
         p8m4g9lDR8ds7DzzbpanfXFmG3nNukiU1pQZVn/YN6S+Y0vcK4Oqcg+NO41Yk9KgKCDW
         RxlgrblB1DbajEsfe1IfqK4itot9MeYTe4azsIHQuwdFSHDVwEGitj1taE/PoP2zt8cL
         OkfQ==
X-Gm-Message-State: APjAAAV4+Q+kFlnhco+ZkSiJyeuJrKR4V5uoov+qP2K5o11rSwBJ2FXW
        y124txFrQ42q5dEXWGC9FV9nvw00L6bssfR1luKb14d2Q0iVng==
X-Google-Smtp-Source: APXvYqw4FrufMrwsWG20g5Vc8KSbXAfu2/rJlkScfVMpc4fL31bGQq9hagdM9w9y1ld98AaKyaZC78IP96NTZbSLwSY=
X-Received: by 2002:a02:cc6c:: with SMTP id j12mr12111505jaq.102.1560984514733;
 Wed, 19 Jun 2019 15:48:34 -0700 (PDT)
MIME-Version: 1.0
References: <20190615040210.GA9112@hari-Inspiron-1545> <CAKv+Gu9-wiJNxPsVn06dBSU8Gchg8LjV=mi0cThZUWywmt2xzQ@mail.gmail.com>
In-Reply-To: <CAKv+Gu9-wiJNxPsVn06dBSU8Gchg8LjV=mi0cThZUWywmt2xzQ@mail.gmail.com>
From:   Matthew Garrett <mjg59@google.com>
Date:   Wed, 19 Jun 2019 15:48:23 -0700
Message-ID: <CACdnJuudmE-MNuO7z87Mm65VaXbRzhOrBEpU5F=yC67uSLytGQ@mail.gmail.com>
Subject: Re: [PATCH] drivers: firmware: efi: fix gcc warning -Wint-conversion
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     Hariprasad Kelam <hariprasad.kelam@gmail.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        tpmdd-devel@lists.sourceforge.net,
        linux-efi <linux-efi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, Jun 19, 2019 at 2:55 AM Ard Biesheuvel
<ard.biesheuvel@linaro.org> wrote:
>
> (+ Jarkko, tpmdd, Matthew)
>
> On Sat, 15 Jun 2019 at 06:02, Hariprasad Kelam
> <hariprasad.kelam@gmail.com> wrote:
> >
> > This patch fixes below warning
> >
> > drivers/firmware/efi/tpm.c:78:38: warning: passing argument 1 of
> > =E2=80=98tpm2_calc_event_log_size=E2=80=99 makes pointer from integer w=
ithout a cast
> > [-Wint-conversion]
> >
> > Signed-off-by: Hariprasad Kelam <hariprasad.kelam@gmail.com>
>
> I think we already have a fix queued for this, no?

It looks like I fixed this in "Don't duplicate events from the final
event log in the TCG2 log" rather than a separate patch - I'm fine
merging this, based on Jarkko's preferences.
