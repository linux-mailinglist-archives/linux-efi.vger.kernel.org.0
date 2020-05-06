Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6325D1C71AA
	for <lists+linux-efi@lfdr.de>; Wed,  6 May 2020 15:29:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728483AbgEFN3M (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 6 May 2020 09:29:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728081AbgEFN3M (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 6 May 2020 09:29:12 -0400
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B56AC061A0F
        for <linux-efi@vger.kernel.org>; Wed,  6 May 2020 06:29:12 -0700 (PDT)
Received: by mail-ot1-x343.google.com with SMTP id g19so1320641otk.5
        for <linux-efi@vger.kernel.org>; Wed, 06 May 2020 06:29:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=c7SLmnE4klnpTd1SZ9Ht0REZux2oXpJ65WbnH469Wzg=;
        b=CyVSzoYsWHRsoot5bAkYTiqb57hYNWb5+Dd9xwzDUIx/Pcl6qSLYMfZrCnTJi6cVNG
         YDaQZKuJmL1pg/MWn5cCMzpseKihGeZR4YuHXDNJ/4x6zIwh2uR7a2y9CAMb8GCvDzml
         W83I4ZZ1+Qjl//iY8JBSipxi749JJzrKLyUA8jEXOyFowGYZ1mIGXE2RtTQfubDpaaMb
         KkEGpbp6VnL6IZVWNRXib/m7tm4eRe5QSAENM7m7xJfqSSc9g8NulqDvv04PUca9HbZm
         GGHrlE160qyi0eleeZjQ9Em7cVo/QG+WeA9WUThCC09xNaPdiM6y65jVPPFTXt7JBcaA
         jGWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=c7SLmnE4klnpTd1SZ9Ht0REZux2oXpJ65WbnH469Wzg=;
        b=qkBRGj8b3qYCwqCHffjkVFJySqlGWOVaqM25gAGd26jOZcy/xwwt358GgxpLEkLqei
         ousjbriEouu+Lmh7MW11CeSdZUyqOR8CLqDcFmXuspsqTcPdAK36riNt7qCX+5j36oNl
         xje/4u78+deEWu5nmrDPg/g9HQqHCJ9XhDvQg0MuURs1505qmAJxwDdwAn0dQ05QV77h
         RKoxh8xuk69spiaPqGgDdAG1fHzimhAZzJqnQ+MQ4bwnD3oewjb26+bis6heYFOwrpFp
         i12Ip4yiR70r61LSN3Ok5Yglug71lYNwd+TvcvM20xovU56ChNQt38YZtfEVqyhXpbWe
         PsaA==
X-Gm-Message-State: AGi0PuZJhGf7l57bl2uwSJqb3CZYUROVF0h/wlFPMd0hLe9WFu/NkZRk
        FWaqwI9HKoNA592zhiGIsluQddTbiMshB+kdMZqnqf90NiT2Ug==
X-Google-Smtp-Source: APiQypLRAthXdsOm1L1Xh7fckzRMCkZLzZpR9SQjXlVr7x94zRagJ7zFM2NDPm0Kwe5zQXn5bpBqJHVjNustIe2fCwA=
X-Received: by 2002:a9d:68c5:: with SMTP id i5mr916578oto.251.1588771751575;
 Wed, 06 May 2020 06:29:11 -0700 (PDT)
MIME-Version: 1.0
From:   =?UTF-8?B?5Lq/5LiA?= <teroincn@gmail.com>
Date:   Wed, 6 May 2020 21:28:59 +0800
Message-ID: <CANTwqXCzoejWKz+x=FnS6uk2THM0qZUW-3YjJpvfwjtuiPi7=w@mail.gmail.com>
Subject: [BUG]is there a memleak in function efivar_create_sysfs_entry?
To:     ardb@kernel.org
Cc:     linux-efi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hi all,
I notice that most of the usage of kobject_init_and_add in drivers are
wrong, and now some drivers code has maken it right,
please see commit dfb5394f804e (https://lkml.org/lkml/2020/4/11/282).

function efivar_create_sysfs_entry() in drivers/firmware/efi/efivars.c may
have the similar issue and leak kobject.
if kobject_init_and_add() failed, the new_var->kobj may already
increased it's refcnt and allocated memory to store it's name,
so a kobject_put is need before return.

static int
efivar_create_sysfs_entry(struct efivar_entry *new_var)
{


    ret = kobject_init_and_add(&new_var->kobj, &efivar_ktype,
  NULL, "%s", short_name);
    kfree(short_name);
    if (ret)
        return ret;

kobject_uevent(&new_var->kobj, KOBJ_ADD);
if (efivar_entry_add(new_var, &efivar_sysfs_list)) {
    efivar_unregister(new_var);
    return -EINTR;
}

    return 0;
}


Best regards,
Lin Yi
