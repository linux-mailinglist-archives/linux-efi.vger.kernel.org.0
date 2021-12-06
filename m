Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EAD446A66D
	for <lists+linux-efi@lfdr.de>; Mon,  6 Dec 2021 20:58:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349382AbhLFUCI (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 6 Dec 2021 15:02:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349432AbhLFUBw (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 6 Dec 2021 15:01:52 -0500
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64A9DC0698C4;
        Mon,  6 Dec 2021 11:58:23 -0800 (PST)
Received: by mail-lj1-x234.google.com with SMTP id e11so22992460ljo.13;
        Mon, 06 Dec 2021 11:58:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=929TJHPLe7zrcpURu9iZozZ6bK1ygfR21xqdGSD4xVI=;
        b=IyMj2cBg2AyxR+mXDzovxRtpINquRfCzNVwnJ7LE6HSDkxQmeZAYrO2jqZ16qqghnl
         zYHLQb6dpYoKYmH2nWlnTqsnTYIvqJxQ/xAej6pSH+gfY1640JiFaLDQkbCBixJLd1KD
         8m2roTTC3CVZs879tP4Dy7LZr0hLJytSyRe63CM5KhPT4LVBVtZDuGsk+sXWuBy4EANM
         s34cJmzCV5yHwPcv4kWSCfvMPmC1/Ix69c+fhOHztzASsQnAGvoxh9Fa/rtMfp+WH+Aw
         tdQ+VxwkAqvLGDtY3NIy9stt4rP6/208zBe4mi4xw4hcREAhauiqpR90UizCO3o+hwPi
         jV0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=929TJHPLe7zrcpURu9iZozZ6bK1ygfR21xqdGSD4xVI=;
        b=efy+pPmJyPbmxiqJ0/MvcEmpnhodHX4R8+FDTViIFUdmGmpW4TjxvlLFVXdIMsCtAf
         lVfBIyVR0xjbhFY06OMbxstl+rHlCxCvV9qqQ6U+4zAeE+6kYDcLDT9RosiHnkmDT6vm
         70bSPfffIFJmjh/IN3kxqlJFzGllKN0uvOelMzspf3NdiQKoGMj1mR9mEdhVGFnllVpF
         4NZV+OAb2YxhjhC/qYTyv7Pqz9O9LZ+L+/Sl/diUFYCoTdYH1E7chqAdS0zG2UpMlwQI
         VHl0OFWIPGSYXWLSB1+yNRaW0lMUYHVuy1S/3wX0rdlodFhvXc7/xImMbgyWmyr8QMP0
         lYxA==
X-Gm-Message-State: AOAM530RZQY0puHcft/rljU7nNIsA6Ypdr+HQjNw7Z4wipHMMpEEgKT5
        rbWqhCfcrk1PFHots7JpU19RltmNQCcaZ3KxRZg=
X-Google-Smtp-Source: ABdhPJwf5PhfnHS2ngP6FIZ0FSSe7aNXUXYludTyP8Vc79o9DP90Qk7gJ/FdfPeOFyYw5pCrvtpzA95yN5wiDl2fTHs=
X-Received: by 2002:a2e:9e8e:: with SMTP id f14mr37901692ljk.366.1638820701509;
 Mon, 06 Dec 2021 11:58:21 -0800 (PST)
MIME-Version: 1.0
References: <20211203192148.585399-1-martin.fernandez@eclypsium.com> <YaxWXACBguZxWmKS@kernel.org>
In-Reply-To: <YaxWXACBguZxWmKS@kernel.org>
From:   Richard Hughes <hughsient@gmail.com>
Date:   Mon, 6 Dec 2021 19:58:10 +0000
Message-ID: <CAD2FfiG9wfeW_2xxZqBi9vsjzEJBRjJUZw+AQy1Taos4fh2TLA@mail.gmail.com>
Subject: Re: [PATCH v3 0/5] x86: Show in sysfs if a memory node is able to do encryption
To:     Mike Rapoport <rppt@kernel.org>
Cc:     Martin Fernandez <martin.fernandez@eclypsium.com>,
        linux-kernel@vger.kernel.org, linux-efi@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, linux-mm@kvack.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        ardb@kernel.org, dvhart@infradead.org, andy@infradead.org,
        gregkh@linuxfoundation.org, rafael@kernel.org,
        akpm@linux-foundation.org, daniel.gutson@eclypsium.com,
        alex.bazhaniuk@eclypsium.com, alison.schofield@intel.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Sun, 5 Dec 2021 at 06:04, Mike Rapoport <rppt@kernel.org> wrote:
> On Fri, Dec 03, 2021 at 04:21:43PM -0300, Martin Fernandez wrote:
> > fwupd project plans to use it as part of a check to see if the users
> > have properly configured memory hardware encryption capabilities.
> I'm missing a description about *how* the new APIs/ABIs are going to be
> used.

We're planning to use this feature in the Host Security ID checks done
at every boot. Please see
https://fwupd.github.io/libfwupdplugin/hsi.html for details. I'm happy
to answer questions or concerns. Thanks!

Richard
