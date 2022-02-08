Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6C944AE426
	for <lists+linux-efi@lfdr.de>; Tue,  8 Feb 2022 23:27:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386618AbiBHW0k (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 8 Feb 2022 17:26:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1386656AbiBHVEw (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 8 Feb 2022 16:04:52 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6884BC0612BA
        for <linux-efi@vger.kernel.org>; Tue,  8 Feb 2022 13:04:51 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id c5-20020a17090a1d0500b001b904a7046dso1586716pjd.1
        for <linux-efi@vger.kernel.org>; Tue, 08 Feb 2022 13:04:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=eclypsium.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=afzJpCERAmk3yFBzidPNdDx8rS5idfCgJ4X6kw/EPaM=;
        b=eEUrW4OF40G7F+WuRB6qBYML3NnN8jyRLUuDZQ36/XwjKQrosY7EncGqdoZ56goO11
         xq22cEWlVcV/nfTZEgwOl4cltBYzFo5qBDhHsxZIXIfbl/ev31PA89aerwPLPjquVt41
         bY0xhOiHnke5u4XhoMvSuQatKLPM9ope1sJvXd2uTxspzkQiDP8VZ4s1wrfo6tk5IrOU
         A6r85p6t3+zI13d14ceOdn91Vz20yvAhdXYKsJQULVcHMNuj5RsQfYF+P5tX1QutEYJE
         6qCcVAOXut7WXPhiIObuboj20J0WcrVEUKTbTC8X33BIepw3pq1fHPDyOd0Q5SaN7CQI
         k9Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=afzJpCERAmk3yFBzidPNdDx8rS5idfCgJ4X6kw/EPaM=;
        b=5jZWrLNa84xcQBkGeTl99g9XuMw2av/vsEuWQEL55PXJSax/nsKE93GdC8mPuVuje1
         UG5yfj1BpNVa6i7KJoiWziLQm/MbuHXc+Y6jewpsEKlXfnTgfa4gm5Mbf0b1YJBD5ioL
         yGRDNovYefpoYKQREe7VGI/FE4lPELFnkLb5yHxJVviDi7Nd0Y4cUL+WFWi49jZCRKKn
         Yky9k78badMcGzLHD1JnI21nLp5XV8kIZ8g/hOO4befl9Cs5fiVOCnRX4c4dT4P/nPRC
         6bW6WH5xY4FuB801EgLu0RvfBmnePpbKHyzDuuIRaMSmVZmup9DyrIH/j50XGhtRmkoS
         muPA==
X-Gm-Message-State: AOAM530aws2Bs1D76Iank8qsW/QNVbfitN+V1PTjq13S8EdhBsVpv77p
        JVLGI5SQPJTJvIxSZfU6CxJF43nkSUe5bhUnECohuA==
X-Google-Smtp-Source: ABdhPJzhPgIonUJWKRLCbon/hP7emWLkYkN+Dx+b87pFcCzMzBNuU1ZCEMqTrJ+4QIVkDxz93NlatPENKIsESM0QRxo=
X-Received: by 2002:a17:902:ab53:: with SMTP id ij19mr6335813plb.45.1644354290468;
 Tue, 08 Feb 2022 13:04:50 -0800 (PST)
MIME-Version: 1.0
References: <20220203164328.203629-1-martin.fernandez@eclypsium.com> <20220203164328.203629-4-martin.fernandez@eclypsium.com>
In-Reply-To: <20220203164328.203629-4-martin.fernandez@eclypsium.com>
From:   Daniel Gutson <daniel.gutson@eclypsium.com>
Date:   Tue, 8 Feb 2022 18:04:39 -0300
Message-ID: <CAFmMkTHUZr8MY0ddgPvnkuo03KwxO_G=bnhEs6QbxUwK+XK=NA@mail.gmail.com>
Subject: Re: [PATCH v6 3/6] x86/e820: Refactor range_update and range_remove
To:     Martin Fernandez <martin.fernandez@eclypsium.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        linux-efi@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-mm@kvack.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, ardb@kernel.org,
        dvhart@infradead.org, andy@infradead.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        rafael@kernel.org, rppt@kernel.org, akpm@linux-foundation.org,
        Richard Hughes <hughsient@gmail.com>,
        Alex Bazhaniuk <alex.bazhaniuk@eclypsium.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, Feb 3, 2022 at 1:44 PM Martin Fernandez
<martin.fernandez@eclypsium.com> wrote:
>
> __e820__range_update and e820__range_remove had a very similar
> implementation with a few lines different from each other, the lines
> that actually perform the modification over the e820_table. The
> similiraties were found in the checks for the different cases on how
> each entry intersects with the given range (if it does at all). These
> checks were very presice and error prone so it was not a good idea to
> have them in both places.
>
> I propose a refactor of those functions, given that I need to create a
> similar one for this patchset.
>
> Add a function to modify a E820 table in a given range. This
> modification is done backed up by two helper structs:
> e820_entry_updater and e820_*_data.
>
> The first one, e820_entry_updater, carries 3 callbacks which function
> as the actions to take on the table.
>
> The other one, e820_*_data carries information needed by the
> callbacks, for example in the case of range_update it will carry the
> type that we are targeting.
>
> Signed-off-by: Martin Fernandez <martin.fernandez@eclypsium.com>
> ---
>  arch/x86/kernel/e820.c | 383 ++++++++++++++++++++++++++++++-----------
>  1 file changed, 283 insertions(+), 100 deletions(-)
>
> diff --git a/arch/x86/kernel/e820.c b/arch/x86/kernel/e820.c
> index bc0657f0deed..89b78c6b345b 100644
> --- a/arch/x86/kernel/e820.c
> +++ b/arch/x86/kernel/e820.c
> @@ -459,144 +459,327 @@ static int __init append_e820_table(struct boot_e820_entry *entries, u32 nr_entr
>         return __append_e820_table(entries, nr_entries);
>  }
>
> +/**
> + * e820_entry_updater - Helper type for __e820__handle_range_update().
> + * @should_update: Return true if @entry needs to be updated, false
> + * otherwise.
> + * @update: Apply desired actions to an @entry that is inside the
> + * range and satisfies @should_update.
> + * @new: Create new entry in the table with information gathered from
> + * @original and @data.
> + *
> + * Each function corresponds to an action that
> + * __e820__handle_range_update() does. Callbacks need to cast @data back
> + * to the corresponding type.
> + */
> +struct e820_entry_updater {
> +       bool (*should_update)(const struct e820_entry *entry, const void *data);
> +       void (*update)(struct e820_entry *entry, const void *data);
> +       void (*new)(struct e820_table *table, u64 new_start, u64 new_size,
> +                   const struct e820_entry *original, const void *data);
> +};
> +
> +/**
> + * e820_remove_data - Helper type for e820__range_remove().
> + * @old_type: old_type parameter of e820__range_remove().
> + * @check_type: check_type parameter of e820__range_remove().
> + *
> + * This is intended to be used as the @data argument for the
> + * e820_entry_updater callbacks.
> + */
> +struct e820_remover_data {
> +       enum e820_type old_type;
> +       bool check_type;
> +};
> +
> +/**
> + * e820_type_updater_data - Helper type for __e820__range_update().
> + * @old_type: old_type parameter of __e820__range_update().
> + * @new_type: new_type parameter of __e820__range_update().
> + *
> + * This is intended to be used as the @data argument for the
> + * e820_entry_updater callbacks.
> + */
> +struct e820_type_updater_data {
> +       enum e820_type old_type;
> +       enum e820_type new_type;
> +};
> +
> +/**
> + * __e820__handle_intersected_range_update() - Helper function for
> + * __e820__handle_range_update().
> + * @table: Target e820_table.
> + * @start: Start of the range.
> + * @size: Size of the range.
> + * @entry: Current entry that __e820__handle_range_update() was
> + * looking into.
> + * @updater: updater parameter of __e820__handle_range_update().
> + * @data: data parameter of __e820__handle_range_update().
> + *
> + * Helper for __e820__handle_range_update to handle the case where
> + * neither the entry completely covers the range nor the range
> + * completely covers the entry.
> + *
> + * Return: The updated size.
> + */
>  static u64 __init
> -__e820__range_update(struct e820_table *table, u64 start, u64 size, enum e820_type old_type, enum e820_type new_type)
> +__e820__handle_intersected_range_update(struct e820_table *table,
> +                                       u64 start,
> +                                       u64 size,
> +                                       struct e820_entry *entry,
> +                                       const struct e820_entry_updater *updater,
> +                                       const void *data)
>  {
>         u64 end;
> -       unsigned int i;
> -       u64 real_updated_size = 0;
> -
> -       BUG_ON(old_type == new_type);
> +       u64 entry_end = entry->addr + entry->size;
> +       u64 inner_start;
> +       u64 inner_end;
> +       u64 updated_size = 0;
>
>         if (size > (ULLONG_MAX - start))
>                 size = ULLONG_MAX - start;
>
>         end = start + size;
> -       printk(KERN_DEBUG "e820: update [mem %#010Lx-%#010Lx] ", start, end - 1);
> -       e820_print_type(old_type);
> -       pr_cont(" ==> ");
> -       e820_print_type(new_type);
> -       pr_cont("\n");
> -
> -       for (i = 0; i < table->nr_entries; i++) {
> -               struct e820_entry *entry = &table->entries[i];
> -               u64 final_start, final_end;
> -               u64 entry_end;
> +       inner_start = max(start, entry->addr);
> +       inner_end = min(end, entry_end);
> +
> +       /* Range and entry do intersect and... */
> +       if (inner_start < inner_end) {
> +               /* Entry is on the left */
> +               if (entry->addr < inner_start) {
> +                       /* Resize current entry */
> +                       entry->size = inner_start - entry->addr;
> +               /* Entry is on the right */
> +               } else {
> +                       /* Resize and move current section */
> +                       entry->addr = inner_end;
> +                       entry->size = entry_end - inner_end;
> +               }
> +               /* Create new entry with intersected region */
> +               updater->new(table, inner_start, inner_end - inner_start, entry, data);
>
> -               if (entry->type != old_type)
> -                       continue;
> +               updated_size += inner_end - inner_start;
> +       } /* Else: [start, end) doesn't cover entry */
>
> -               entry_end = entry->addr + entry->size;
> +       return updated_size;
> +}
>
> -               /* Completely covered by new range? */
> -               if (entry->addr >= start && entry_end <= end) {
> -                       entry->type = new_type;
> -                       real_updated_size += entry->size;
> -                       continue;
> -               }
> +/** __e820__handle_range_update(): Helper function to update a address
> + * range in a e820_table
> + * @table: e820_table that we want to modify.
> + * @start: Start of the range.
> + * @size: Size of the range.
> + * @updater: Callbacks to modify the table.
> + * @data: Information to modify the table.
> + *
> + * Update the table @table in [@start, @start + @size) doing the
> + * actions given in @updater.
> + *
> + * Return: The updated size.
> + */
> +static u64 __init
> +__e820__handle_range_update(struct e820_table *table,
> +                           u64 start,
> +                           u64 size,
> +                           const struct e820_entry_updater *updater,
> +                           const void *data)
> +{
> +       u64 updated_size = 0;
> +       u64 end;
> +       unsigned int i;
>
> -               /* New range is completely covered? */
> -               if (entry->addr < start && entry_end > end) {
> -                       __e820__range_add(table, start, size, new_type);
> -                       __e820__range_add(table, end, entry_end - end, entry->type);
> -                       entry->size = start - entry->addr;
> -                       real_updated_size += size;
> -                       continue;
> -               }
> +       if (size > (ULLONG_MAX - start))
> +               size = ULLONG_MAX - start;
>
> -               /* Partially covered: */
> -               final_start = max(start, entry->addr);
> -               final_end = min(end, entry_end);
> -               if (final_start >= final_end)
> -                       continue;
> +       end = start + size;
>
> -               __e820__range_add(table, final_start, final_end - final_start, new_type);
> +       for (i = 0; i < table->nr_entries; i++) {
> +               struct e820_entry *entry = &table->entries[i];
> +               u64 entry_end = entry->addr + entry->size;
> +
> +               if (updater->should_update(data, entry)) {
> +                       /* Range completely covers entry */
> +                       if (entry->addr >= start && entry_end <= end) {
> +                               updater->update(entry, data);
> +                               updated_size += entry->size;
> +                       /* Entry completely covers range */
> +                       } else if (start > entry->addr && end < entry_end) {
> +                               /* Resize current entry */
> +                               entry->size = start - entry->addr;
> +
> +                               /* Create new entry with intersection region */
> +                               updater->new(table, start, size, entry, data);
> +
> +                               /*
> +                                * Create a new entry for the leftover
> +                                * of the current entry
> +                                */
> +                               __e820__range_add(table, end, entry_end - end,
> +                                                 entry->type);
> +
> +                               updated_size += size;
> +                       } else {
> +                               updated_size =
> +                                       __e820__handle_intersected_range_update(table, start, size,
> +                                                                               entry, updater, data);
> +                       }
> +               }
> +       }
>
> -               real_updated_size += final_end - final_start;
> +       return updated_size;
> +}
>
> -               /*
> -                * Left range could be head or tail, so need to update
> -                * its size first:
> -                */
> -               entry->size -= final_end - final_start;
> -               if (entry->addr < final_start)
> -                       continue;
> +static bool __init type_updater__should_update(const struct e820_entry *entry,
> +                                              const void *data)
> +{
> +       struct e820_type_updater_data *type_updater_data =
> +               (struct e820_type_updater_data *)data;

Please preserve const correctness. You are removing the const qualifier.

>
> -               entry->addr = final_end;
> -       }
> -       return real_updated_size;
> +       return entry->type == type_updater_data->old_type;
>  }
>
> -u64 __init e820__range_update(u64 start, u64 size, enum e820_type old_type, enum e820_type new_type)
> +static void __init type_updater__update(struct e820_entry *entry,
> +                                       const void *data)
>  {
> -       return __e820__range_update(e820_table, start, size, old_type, new_type);
> +       struct e820_type_updater_data *type_updater_data =
> +               (struct e820_type_updater_data *)data;
> +
> +       entry->type = type_updater_data->new_type;
>  }
>
> -static u64 __init e820__range_update_kexec(u64 start, u64 size, enum e820_type old_type, enum e820_type  new_type)
> +static void __init type_updater__new(struct e820_table *table, u64 new_start,
> +                                    u64 new_size,
> +                                    const struct e820_entry *original,
> +                                    const void *data)
>  {
> -       return __e820__range_update(e820_table_kexec, start, size, old_type, new_type);
> +       struct e820_type_updater_data *type_updater_data =
> +               (struct e820_type_updater_data *)data;
> +
> +       __e820__range_add(table, new_start, new_size,
> +                         type_updater_data->new_type);
>  }
>
> -/* Remove a range of memory from the E820 table: */
> -u64 __init e820__range_remove(u64 start, u64 size, enum e820_type old_type, bool check_type)
> +static u64 __init __e820__range_update(struct e820_table *table, u64 start,
> +                                      u64 size, enum e820_type old_type,
> +                                      enum e820_type new_type)
>  {
> -       int i;
> -       u64 end;
> -       u64 real_removed_size = 0;
> +       struct e820_entry_updater updater = {
> +               .should_update = type_updater__should_update,
> +               .update = type_updater__update,
> +               .new = type_updater__new
> +       };
>
> -       if (size > (ULLONG_MAX - start))
> -               size = ULLONG_MAX - start;
> +       struct e820_type_updater_data data = {
> +               .old_type = old_type,
> +               .new_type = new_type
> +       };
>
> -       end = start + size;
> -       printk(KERN_DEBUG "e820: remove [mem %#010Lx-%#010Lx] ", start, end - 1);
> -       if (check_type)
> -               e820_print_type(old_type);
> +       BUG_ON(old_type == new_type);
> +
> +       printk(KERN_DEBUG "e820: update [mem %#018Lx-%#018Lx] ", start,
> +              start + size - 1);
> +       e820_print_type(old_type);
> +       pr_cont(" ==> ");
> +       e820_print_type(new_type);
>         pr_cont("\n");
>
> -       for (i = 0; i < e820_table->nr_entries; i++) {
> -               struct e820_entry *entry = &e820_table->entries[i];
> -               u64 final_start, final_end;
> -               u64 entry_end;
> +       return __e820__handle_range_update(table, start, size, &updater, &data);
> +}
>
> -               if (check_type && entry->type != old_type)
> -                       continue;
> +static bool __init remover__should_update(const struct e820_entry *entry,
> +                                         const void *data)
> +{
> +       struct e820_remover_data *remover_data =
> +               (struct e820_remover_data *)data;
>
> -               entry_end = entry->addr + entry->size;
> +       return !remover_data->check_type ||
> +              entry->type == remover_data->old_type;
> +}
>
> -               /* Completely covered? */
> -               if (entry->addr >= start && entry_end <= end) {
> -                       real_removed_size += entry->size;
> -                       memset(entry, 0, sizeof(*entry));
> -                       continue;
> -               }
> +static void __init remover__update(struct e820_entry *entry, const void *data)
> +{
> +       memset(entry, 0, sizeof(*entry));
> +}
>
> -               /* Is the new range completely covered? */
> -               if (entry->addr < start && entry_end > end) {
> -                       e820__range_add(end, entry_end - end, entry->type);
> -                       entry->size = start - entry->addr;
> -                       real_removed_size += size;
> -                       continue;
> -               }
> +static void __init remover__new(struct e820_table *table, u64 new_start,
> +                               u64 new_size, const struct e820_entry *original,
> +                               const void *data)
> +{
> +}
>
> -               /* Partially covered: */
> -               final_start = max(start, entry->addr);
> -               final_end = min(end, entry_end);
> -               if (final_start >= final_end)
> -                       continue;
> +/**
> + * e820__range_remove() - Remove an address range from e820_table.
> + * @start: Start of the address range.
> + * @size: Size of the address range.
> + * @old_type: Type of the entries that we want to remove.
> + * @check_type: Bool to decide if ignore @old_type or not.
> + *
> + * Remove [@start, @start + @size) from e820_table. If @check_type is
> + * true remove only entries with type @old_type.
> + *
> + * Return: The size removed.
> + */
> +u64 __init e820__range_remove(u64 start, u64 size, enum e820_type old_type,
> +                             bool check_type)
> +{
> +       struct e820_entry_updater updater = {
> +               .should_update = remover__should_update,
> +               .update = remover__update,
> +               .new = remover__new
> +       };
> +
> +       struct e820_remover_data data = {
> +               .check_type = check_type,
> +               .old_type = old_type
> +       };
> +
> +       printk(KERN_DEBUG "e820: remove [mem %#018Lx-%#018Lx] ", start,
> +              start + size - 1);
> +       if (check_type)
> +               e820_print_type(old_type);
> +       pr_cont("\n");
>
> -               real_removed_size += final_end - final_start;
> +       return __e820__handle_range_update(e820_table, start, size, &updater,
> +                                           &data);
> +}
>
> -               /*
> -                * Left range could be head or tail, so need to update
> -                * the size first:
> -                */
> -               entry->size -= final_end - final_start;
> -               if (entry->addr < final_start)
> -                       continue;
> +/**
> + * e820__range_update() - Update the type of a given address range in
> + * e820_table.
> + * @start: Start of the range.
> + * @size: Size of the range.
> + * @old_type: Type that we want to change.
> + * @new_type: New type to replace @old_type.
> + *
> + * Update type of addresses in [@start, @start + @size) from @old_type
> + * to @new_type in e820_table.
> + *
> + * Return: The size updated.
> + */
> +u64 __init e820__range_update(u64 start, u64 size, enum e820_type old_type,
> +                             enum e820_type new_type)
> +{
> +       return __e820__range_update(e820_table, start, size, old_type, new_type);
> +}
>
> -               entry->addr = final_end;
> -       }
> -       return real_removed_size;
> +/**
> + * e820__range_update_kexec() - Update the type of a given address
> + * range in e820_table_kexec.
> + * @start: Start of the range.
> + * @size: Size of the range.
> + * @old_type: Type that we want to change.
> + * @new_type: New type to replace @old_type.
> + *
> + * Update type of addresses in [@start, @start + @size) from @old_type
> + * to @new_type in e820_table_kexec.
> + *
> + * Return: The size updated.
> + */
> +static u64 __init e820__range_update_kexec(u64 start, u64 size,
> +                                          enum e820_type old_type,
> +                                          enum e820_type new_type)
> +{
> +       return __e820__range_update(e820_table_kexec, start, size, old_type, new_type);
>  }
>
>  void __init e820__update_table_print(void)
> --
> 2.30.2
>
