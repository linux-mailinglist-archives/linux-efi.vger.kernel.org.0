Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 51C09126E54
	for <lists+linux-efi@lfdr.de>; Thu, 19 Dec 2019 21:04:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726908AbfLSUET (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 19 Dec 2019 15:04:19 -0500
Received: from mail-il1-f193.google.com ([209.85.166.193]:36527 "EHLO
        mail-il1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726907AbfLSUET (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 19 Dec 2019 15:04:19 -0500
Received: by mail-il1-f193.google.com with SMTP id b15so5923481iln.3
        for <linux-efi@vger.kernel.org>; Thu, 19 Dec 2019 12:04:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QtWy4/0bANwEOBCguslY/V6rlnrjgMzA5x9nUZ80g7E=;
        b=fSgFdW+rC3Ei84vA+fxxdcGtnHOhdHd7Munr+1TcXh0oZsPxyZkjmXhcho55+hi78C
         b57GahOGoU2qPWy/IEv+b/9gqho5WqCWXGcifzJQ3+ajfLY0Fux2K1eQ7t2FAJGTY1G/
         vknAf0ROmYf8HtC6JuBEwR/hnw1htTiHPI5q44Q+wDrWufovJsJj5SZzsuh+req+jvO7
         MbFdVLYKAfwK2iU1n0kvQkUjTHWEvANc7dMpmd/mYzfyqsbQVp3KO/lwlBRHu3aZHsSW
         cGTR51u1546rQYOslhZJvqaJvH3Nqk5Yw+EdMd/gTIlE1YWZl3SBLD3Q97y+u3fXNa2U
         3j8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QtWy4/0bANwEOBCguslY/V6rlnrjgMzA5x9nUZ80g7E=;
        b=PRsYe88s5r/CgKkpxA2LaqjAXnheGt58OqavJ8aqZqBOWAcSZIcOZpZvJ3hlTZCABw
         iiVvr1r0Q8MByRIy3kjskoaxTTbYp3oh4rH2D6syk3ihyz9PjsPlmELJk5qUhcsxknyj
         0QNwo27YRSAiKH5pfb1FCT1DY8/uufWY++48sXnKoW8lDnls8rL0JDR+FBWDBaA++RGe
         3tT9A4BQyzDbIAkERMDZVzHmo8KT510+Gl4aljCmA9A0P7bH9gKSn+QG9m8mjxUkzg4H
         IRvODbar1xCz7+4ixBzN1AIhul4LUm06aLGNkSRzOegD3CtZmtTDhOmYDjAvJAncvsU/
         Z6kg==
X-Gm-Message-State: APjAAAUIdkTRvjiI7/wVAP4n3GnUtmpt11G0cJRVPKz/pgbRAR9djiEQ
        O72Jarx3U9XCdVaH8VLBsqhJ99EmspRsTF5DqVztJv7h
X-Google-Smtp-Source: APXvYqwFiFv0TIk01BJBaEP0ITAwltbUwLp7yTk0fV8Ja7Jun9cf0049TzEatDon5Gv+eVyZ+XEkcvbMNWIjnO33z4s=
X-Received: by 2002:a92:d609:: with SMTP id w9mr9221718ilm.46.1576785857195;
 Thu, 19 Dec 2019 12:04:17 -0800 (PST)
MIME-Version: 1.0
References: <20191218170139.9468-1-ardb@kernel.org> <20191218170139.9468-22-ardb@kernel.org>
 <CALCETrWLMeSbmL_ff=AOmuswxWgvRu75cpNPz9SZgeNwex+ygg@mail.gmail.com> <CAKv+Gu-BNNmix9vcR6y1UQZSH5BDOcqeWj=2XM75OvxDwQ8DoQ@mail.gmail.com>
In-Reply-To: <CAKv+Gu-BNNmix9vcR6y1UQZSH5BDOcqeWj=2XM75OvxDwQ8DoQ@mail.gmail.com>
From:   Matthew Garrett <mjg59@google.com>
Date:   Thu, 19 Dec 2019 12:04:06 -0800
Message-ID: <CACdnJuuBpwiLMV7M8WYvkUf3cZP1tEsFz1Ot=qTk00KBsRC54Q@mail.gmail.com>
Subject: Re: [PATCH v2 21/21] efi: Allow disabling PCI busmastering on bridges
 during boot
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Arvind Sankar <nivedita@alum.mit.edu>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, Dec 19, 2019 at 5:17 AM Ard Biesheuvel
<ard.biesheuvel@linaro.org> wrote:

> Fair enough. I'll change this to [no_]disable_early_pci_dma (assuming
> Matthew doesn't object to the exact shade of this bikeshed)

I'm fine with that.
