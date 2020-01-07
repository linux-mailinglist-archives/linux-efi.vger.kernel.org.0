Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C18F6132DD8
	for <lists+linux-efi@lfdr.de>; Tue,  7 Jan 2020 19:00:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728366AbgAGSAL (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 7 Jan 2020 13:00:11 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:46841 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728292AbgAGSAK (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 7 Jan 2020 13:00:10 -0500
Received: by mail-wr1-f65.google.com with SMTP id z7so375897wrl.13
        for <linux-efi@vger.kernel.org>; Tue, 07 Jan 2020 10:00:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4avhs8wOdmaxMNZFNNhuy5O1rkBv12FPijImt/ejG/k=;
        b=GVQwCtK1bktHHhkrsp00ucUZWmpd++nsBEXMdIbp323RFHf9VLo2GWVuIGGQxDrn72
         03evoRsVpCvCioZn60tKjVS7ukdm0g8fgh+bJw6rb5t6QjEBu8KHJwOo+CBttbaVM1oj
         OARrMjN/D05/tcKojlbOps/ZSdwKyI0ErZi5r0hxZxztDqobGFxbeEOx72KIkHa7ye7x
         cRU7s8P6gms6LPnlpGn1+PcA5IrbAX9PIaoyVfH1g7cKk5SShnOtKL/9735Uu8Wqh/NL
         72wQ/YlbsUUjO6nPv+tGgrPKpWECzCmaG7ktImsFjbllapEva0lpdJY1ce5Wynawzq0y
         cLHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4avhs8wOdmaxMNZFNNhuy5O1rkBv12FPijImt/ejG/k=;
        b=Kq+nL0q1Oyjpu7Lch1C/N8vo/gle3cjJjPzAElTwOL+fz0FyxDPaTTcpwkBFDEsKcd
         wEycChlu/wAyIgZXDzbw/INfMNU0lj18NXKOGo2vs73kVUvzD0SuZozG4P6qGuT48q26
         oZZLB4prPfqYcQYg+JgbPVX5EUwEdbqay+Ytg4y0ciud+x7PBoFSnoPN03mPu6yikRMW
         /CpCJ75bsMmhQ5du7jLwgv6LkMCWQcEG2SpJ8QAJIk347Mb+eHblWsKjkR1Wki2Invjr
         U4A3BrZ6gHCojcI5Z6HBwQthj3HYUB+PiX+vFhstYIjqyxFDbHxeJj5gdBR77J1N6zZ6
         zXXw==
X-Gm-Message-State: APjAAAXiYxIj5ysfr9ojn096FY3nFsWhxdYoc7Sr6IrUmgxhNHwSMzVa
        8hUFdN7siQ3RBjT12u6akeTgaQa1SnUMoiG3rqfliA==
X-Google-Smtp-Source: APXvYqxHa2a6+kWr8aYxZpPmuWy5I//CVHTMDUE2HGsmk6F+d8ehPOgckaiwtakJNldtm2MHlQSnLYy98xFnjXAFRCU=
X-Received: by 2002:a5d:46c1:: with SMTP id g1mr309796wrs.200.1578420008822;
 Tue, 07 Jan 2020 10:00:08 -0800 (PST)
MIME-Version: 1.0
References: <20200107135500.644618-1-nivedita@alum.mit.edu>
 <CAKv+Gu8HE-QJBpo=S_uUbqkO8BfbKyrp2+nCTxWhPVNMU1E37g@mail.gmail.com>
 <CAKv+Gu_+a4igmTHhMgg17B2oH5f=KRM2g2CBGy+LnF5wYsarng@mail.gmail.com>
 <20200107142125.GA652888@rani.riverdale.lan> <CAKv+Gu-xDaTBVKJ=9ya74giBZ=LdX2r-8-LiFJWzcUofthGv7w@mail.gmail.com>
 <20200107142732.GB652888@rani.riverdale.lan> <CAKv+Gu8v-5DXWh5ZaY0omrVNh46TEourpcf2Hv3TrsbCUtLFng@mail.gmail.com>
 <20200107175829.GA1599060@rani.riverdale.lan>
In-Reply-To: <20200107175829.GA1599060@rani.riverdale.lan>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Tue, 7 Jan 2020 18:59:57 +0100
Message-ID: <CAKv+Gu-PU=LqT7MEbSH-0GnJOdakDeaC=ANdmag6JptcfJEJtA@mail.gmail.com>
Subject: Re: [PATCH 0/3] Relocate GOT before calling EFI stub
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue, 7 Jan 2020 at 18:58, Arvind Sankar <nivedita@alum.mit.edu> wrote:
>
> On Tue, Jan 07, 2020 at 03:28:31PM +0100, Ard Biesheuvel wrote:
> >
> > Unfortunately, the command line option implements a weaker form of
> > visibility than the pragma, so it probably comes down to setting the
> > pragma in a .h file that gets -include'd via the command line so it is
> > guaranteed to be seen first.
>
> Tried hacking that in and it works, tested with gcc 4.6.4.

Excellent. But in my testing locally, I don't get any GOT entries in
the first place, strangely enough. So what changes in the output for
you with visibility hidden compared to before?
