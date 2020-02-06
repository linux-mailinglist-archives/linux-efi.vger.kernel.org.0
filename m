Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D0464154F6F
	for <lists+linux-efi@lfdr.de>; Fri,  7 Feb 2020 00:44:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726509AbgBFXoR (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 6 Feb 2020 18:44:17 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:36456 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726502AbgBFXoR (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 6 Feb 2020 18:44:17 -0500
Received: by mail-wr1-f65.google.com with SMTP id z3so528232wru.3
        for <linux-efi@vger.kernel.org>; Thu, 06 Feb 2020 15:44:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=d02kj/Sz33fa+befgXZVyFREBr0vJnFUZeMKa31YhvU=;
        b=m0BHB8BWirguKwZ62oJ9sCeWiNk4ZMjTSxggAILO04O6yhuLcNQpLniOi4JGJ4UJYv
         XAGdqJxP3BJbWUPQmnoBeHwmH/sbn/bXHj+8NFbDkzfZRgt30L3uLME77sKc3GjEa+kv
         PBU6gqQXEc+1vBY3kv10MJlk1JrcWKE4Q/VsPMzLoBWjE4ozmf8jcNsqn/wVC9PNFn38
         qpvoKl653a+mB4e1T32mXBtUCX+LtENNUatP9IEME69ISo/LqbTSq2ESV2x7/GhXZQhv
         HmI3jO7GhCTaR9DNfUNSQt/0WU4tPpx3NasR1R4x1vdLbIeQO3gFDKnu3jAUyy1uB87E
         HwQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=d02kj/Sz33fa+befgXZVyFREBr0vJnFUZeMKa31YhvU=;
        b=i+AqVYB41dKxrZgdzh64gXic2k3xiGbnx50CKI2qq/2E8cD8ka1h+3ZnHPno/6y2pr
         QRNk7R+Bpw9YzpLpvA/JJ2Ms+zklCkW1pt7uTo7m7vZ1SXyZYkTzCq1g1Ia1EKyS0k4g
         QE7CW15jn5YbipVR+6Y5ccSC+A9+518pUDpYQHliukHeOuuZmfzlyECxj9RGviFxmdP3
         tlv8rydarvkwMratorwkjeNl480oF/E4SpeRRKoZqczB0Qg+zjl1S6Luho+85LS1Xq7Y
         bf6FV8L9oRR+xBux3fwfzmqMQWX+rwfOD2RBx/XavcoNNeuYxu+UKpyj/iHEnqkB2zGs
         HxvQ==
X-Gm-Message-State: APjAAAXpvcAziwTK302ZE9VYVfCDJqVUh9hcZ252H+l92lo7AedVBS7U
        CJPJp2bn9NqC+M7gCK9jjLTTqQO6/e6lnD35afnt1A==
X-Google-Smtp-Source: APXvYqxpArkCAj89URKq3zHxyBge3u7GNKCttPWI1urPSnesFArTXUqzR/IIYDcODxWqpNQ9cYV4fjYwH+o67pLFahQ=
X-Received: by 2002:adf:8564:: with SMTP id 91mr518010wrh.252.1581032655972;
 Thu, 06 Feb 2020 15:44:15 -0800 (PST)
MIME-Version: 1.0
References: <20200206140352.6300-1-ardb@kernel.org> <20200206140352.6300-3-ardb@kernel.org>
 <ea0b44d5-c9e4-943a-da81-8b4c8f1a371d@gmx.de>
In-Reply-To: <ea0b44d5-c9e4-943a-da81-8b4c8f1a371d@gmx.de>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Thu, 6 Feb 2020 23:44:04 +0000
Message-ID: <CAKv+Gu8nfoz+5jXn_8Pdwp9Hs=jxvanwMmSYbu3otq=EPL41qw@mail.gmail.com>
Subject: Re: [PATCH 2/2] efi/libstub: take noinitrd cmdline argument into
 account for devpath initrd
To:     Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Laszlo Ersek <lersek@redhat.com>,
        Leif Lindholm <leif@nuviainc.com>,
        Peter Jones <pjones@redhat.com>,
        Matthew Garrett <mjg59@google.com>,
        Alexander Graf <agraf@csgraf.de>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Daniel Kiper <daniel.kiper@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, 6 Feb 2020 at 18:33, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
>
> On 2/6/20 3:03 PM, Ard Biesheuvel wrote:
> > One of the advantages of using what basically amounts to a callback
> > interface into the bootloader for loading the initrd is that it provides
> > a natural place for the bootloader or firmware to measure the initrd
> > contents while they are being passed to the kernel.
> >
> > Unfortunately, this is not a guarantee that the initrd will in fact be
> > loaded and its /init invoked by the kernel, since the command line may
> > contain the 'noinitrd' option, in which case the initrd is ignored, but
> > this will not be reflected in the PCR that covers the initrd measurement.
>
> Does PCR here refer to the TPM Platform Configuration Register?
>

Yes.
