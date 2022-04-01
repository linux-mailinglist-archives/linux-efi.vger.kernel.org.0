Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A512C4EEA17
	for <lists+linux-efi@lfdr.de>; Fri,  1 Apr 2022 11:05:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231742AbiDAJGz (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 1 Apr 2022 05:06:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231157AbiDAJGy (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 1 Apr 2022 05:06:54 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AD8E197FBB;
        Fri,  1 Apr 2022 02:05:05 -0700 (PDT)
Date:   Fri, 1 Apr 2022 11:05:00 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1648803901;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tR9DgVlpSOJuydn7n6nmqNv1be3Re6NKi4LsEiFJsmA=;
        b=upOCUZdQ1W7WMALoNxGm7U67PmhdPX40qo79mt2GS3MWDKxdYCzPGM7Bm+c/K5FUOY55r7
        z31qwmXi4nm5ceBL70BH4UPuiuW02OjpkAK4hyngLLDxjHm/LJEIaRaW1WvmwsyJsCZ/m4
        +VHmHzxzfyCzDdiZlr1rAGZsGQbXue7IbQhDHbSuX861v8nNuEJ95DJAOSTL00P8WBaUBX
        WO+U7hQuCnpYsN89NweqHFYC+eJwLNJkVR0VCXK3KP4NBkfzjpP3Vk4G4fAnDCo8AvW1H3
        +OMgcYlWtELOJ3CvRK1eZoRV5QmDJXwpAv3ooK+7+ajmboWtsS/2E+pvC8tpEA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1648803901;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tR9DgVlpSOJuydn7n6nmqNv1be3Re6NKi4LsEiFJsmA=;
        b=825AAtMzXSW8A6THac+dFj4CeDwCsfOO3CfjAxxvptsgp2WpaA/OjROo/WynlXLp0rJo9J
        1C8+IID19gpkJ+CQ==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Javier Martinez Canillas <javierm@redhat.com>,
        "Ahmed S. Darwish" <a.darwish@linutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        Brian Masney <bmasney@redhat.com>, Al Stone <ahs3@redhat.com>,
        Peter Robinson <pbrobinson@gmail.com>,
        Robbie Harwood <rharwood@redhat.com>,
        Peter Jones <pjones@redhat.com>,
        Alexander Larsson <alexl@redhat.com>,
        Andrew Halaney <ahalaney@redhat.com>,
        linux-rt-users@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v2] efi: Allow to enable EFI runtime services by default
 on RT
Message-ID: <YkbAPPDJyiZ/FLN1@linutronix.de>
References: <20220331151654.184433-1-javierm@redhat.com>
 <CAMj1kXHgyjB_BVzXx+CK0tBuJpZ3h=8XKus7nWiyovECjVQ0gw@mail.gmail.com>
 <YkYA/Wpqa/PMczkp@lx-t490>
 <CAFOAJEeKNy0HW82W6HV_49d5sc5L0m62QDfY9qA1906_ZzGRYg@mail.gmail.com>
 <Ykas9iX/D3WURx8T@linutronix.de>
 <78a0360d-1a27-5280-10bf-d27d1d306fa5@redhat.com>
 <CAMj1kXGEBtcdD+3MFK5gO6vCw8dg=ruTthdWGVUu1eJpgZXf8Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAMj1kXGEBtcdD+3MFK5gO6vCw8dg=ruTthdWGVUu1eJpgZXf8Q@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 2022-04-01 10:34:03 [+0200], Ard Biesheuvel wrote:
> I don't think we need another warning.

exactly.

> The kernel log already tells you whether or not EFI runtime services
> are enabled.

Correct. We either warn about all problematic options or none but this
is independent of this patch.

Sebastian
