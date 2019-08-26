Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CA77F9D526
	for <lists+linux-efi@lfdr.de>; Mon, 26 Aug 2019 19:44:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387447AbfHZRoo (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 26 Aug 2019 13:44:44 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:44054 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729535AbfHZRoo (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 26 Aug 2019 13:44:44 -0400
Received: by mail-io1-f66.google.com with SMTP id j4so30978936iog.11
        for <linux-efi@vger.kernel.org>; Mon, 26 Aug 2019 10:44:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PwvVpT1oUpfrmNJJmsG0tncnKf6cWYXcpRZCvToipU8=;
        b=VpuWqE51rpFASY2s3XWeOx28q/DN6nmZRMMGHiowJGrKlMQmmqmb75253Jwg58zNNs
         smSttCxSxJw4s5NoFeoeGZ4P6r5O5317qTF2mVmwBmU/KiqeDl767A2CpIlrdLhVNcVw
         wEl8hE6WZNfTpBnxSMII3dv+T/bpunyNOmG0M1gDjLadWKlQJcPSbGQjSgH9iCik7kGm
         vGii4TC8XDKvI8BS2iTYZWLFGkF1+XR7K0JeN2bEb1CeZXcHxvQzrLhStO3XcekVomEs
         fUBETzqUtLmWN5d7KxQG2Tin0Y/9wYWEq5mKVxFG4U+KkdChsRkW9kTi1sZId52zvdZl
         pNsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PwvVpT1oUpfrmNJJmsG0tncnKf6cWYXcpRZCvToipU8=;
        b=OIN22q3W1+UdB+XIjFzOZsz8dz/WGo4pfZpwKbXTyiYF3Xbhk31pwwYs8Nq6Qbzv/w
         cN0Zw9k9XkUPuYrIaricTL5gMyVYlvz5iBg9mKlKw28BrDTTDWS8/BRuy260DxU5vocy
         rfkD3okkLSM54EVJGA1gCvNeM1lCFPF2we2o673LnVnL8TUnySUgihdzMcWkSvPQX4CU
         Oh4fPGFVj+mFvThuSKGkXtraJDY35EfusalnE+BVaiTGmn8ATEW8TKUAZ04+j7aEVoBi
         maNlWxTMMrhZcwvpDRIFD6cv8vz2KFahBuyQT+XkiN5c0Ky2G5+9cfaC3dAUUpdTv1r3
         6AAA==
X-Gm-Message-State: APjAAAXM63y9im5ro1MB63GDN0R/84lB18/fGU2saBPH6B9GS19vRBeu
        wAgB/0ZgKfUJ3joPZH+3o9iFO5l+0PFdPMwFMpuNdA==
X-Google-Smtp-Source: APXvYqzTkrP6wPdElkAwQ8BNk1dvlidtBN/v9J8swrvxEEGT75u29yQXpPShFLsjxPNKZYU88YmYZkXgkv6JTJTD2Wk=
X-Received: by 2002:a5e:9404:: with SMTP id q4mr3975008ioj.46.1566841483000;
 Mon, 26 Aug 2019 10:44:43 -0700 (PDT)
MIME-Version: 1.0
References: <20190826153028.32639-1-pjones@redhat.com> <20190826162823.4mxkwhd7mbtro3zy@linux.intel.com>
In-Reply-To: <20190826162823.4mxkwhd7mbtro3zy@linux.intel.com>
From:   Matthew Garrett <mjg59@google.com>
Date:   Mon, 26 Aug 2019 10:44:31 -0700
Message-ID: <CACdnJuuB_ExhOOtA8Uh7WO42TSNfRHuGaK4Xo=5SbdfWDKr7wA@mail.gmail.com>
Subject: Re: [PATCH 1/2] efi+tpm: Don't access event->count when it isn't mapped.
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     Peter Jones <pjones@redhat.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Roberto Sassu <roberto.sassu@huawei.com>,
        Bartosz Szczepanek <bsz@semihalf.com>,
        Lyude Paul <lyude@redhat.com>,
        linux-efi <linux-efi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Mon, Aug 26, 2019 at 9:28 AM Jarkko Sakkinen
<jarkko.sakkinen@linux.intel.com> wrote:
>
> On Mon, Aug 26, 2019 at 11:30:27AM -0400, Peter Jones wrote:
> > Some machines generate a lot of event log entries.  When we're
> > iterating over them, the code removes the old mapping and adds a
> > new one, so once we cross the page boundary we're unmapping the page
> > with the count on it.  Hilarity ensues.
> >
> > This patch keeps the info from the header in local variables so we don't
> > need to access that page again or keep track of if it's mapped.
> >
> > Signed-off-by: Peter Jones <pjones@redhat.com>
> > Tested-by: Lyude Paul <lyude@redhat.com>
>
> Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Acked-by: Matthew Garrett <mjg59@google.com>

Jarkko, these two should probably go to 5.3 if possible - I
independently had a report of a system hitting this issue last week
(Intel apparently put a surprising amount of data in the event logs on
the NUCs).
