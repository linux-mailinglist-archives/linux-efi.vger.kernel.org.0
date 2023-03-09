Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E3C86B2C24
	for <lists+linux-efi@lfdr.de>; Thu,  9 Mar 2023 18:37:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230375AbjCIRhs (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 9 Mar 2023 12:37:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230450AbjCIRhf (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 9 Mar 2023 12:37:35 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3987FA8E8;
        Thu,  9 Mar 2023 09:37:27 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 774FDB8203C;
        Thu,  9 Mar 2023 17:37:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00F99C433A8;
        Thu,  9 Mar 2023 17:37:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678383445;
        bh=CWlUbqAAddyDFhmkqtZWKlISSR5EHW+2U+/ieYMiR/A=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=bVbvuGuesLmXr5O1qaVveSU8WueweYxP+UZXZilJlf3sQ5z0owkLsbIZ6/kJF1RMZ
         iFoQhXNoDQxfIt9pv7IcPsk/Vq/FXSmp2au+M3wKaZis1Pb5qWzNQaY2QC0mS2JePi
         DciK3Jg4M/UyqMNAiiGh4v/9/W5ZMk/PWPBqUMOo2QW8UDRhaAbmuQLrJsFYr0Uv7d
         bnKqvYuUFyCzOlxGioWi8KuQ42iFhw14R1/2Ts3OuAYcs1AG4cvvlSeM8hnwPxpUGq
         M3siXWG7DoWarHYNJlzvC/kb6qlF7mQbSsPFjod2rSi7R1easZ1k22hmZtDQyfdiuA
         E4GQ1Tu/RjGGw==
Received: by mail-lf1-f42.google.com with SMTP id j11so3254364lfg.13;
        Thu, 09 Mar 2023 09:37:24 -0800 (PST)
X-Gm-Message-State: AO0yUKWtTsIWwXkvEohSfg+j+AGcxFKu/qZKPMRu/MC+0X9+FnZ/TgNt
        kq0DjzGJ64PJtqyf2JIr3VB8vvffAGTpI2Amt9U=
X-Google-Smtp-Source: AK7set+vk9GA3M9GPjdkSFXH46ZH2SRJuUl21eGrGTAbLvYOrQ460XcSrMbo08l4hjaQCzebpjdTo6P0dshmj6tFQog=
X-Received: by 2002:a19:c212:0:b0:4d5:ca42:aee4 with SMTP id
 l18-20020a19c212000000b004d5ca42aee4mr7107475lfc.4.1678383442780; Thu, 09 Mar
 2023 09:37:22 -0800 (PST)
MIME-Version: 1.0
References: <cover.1671098103.git.baskov@ispras.ru> <b80ee86cd2ef39e7e15d93ec6c5869946780b6e5.1671098103.git.baskov@ispras.ru>
 <CAMj1kXG_RTcU9T1FLQX3ZyqwP8xrjaXbyOZtZveL_JkoNaRWsw@mail.gmail.com>
 <554189e4545153a6f6271a870c1770a7@ispras.ru> <CAMj1kXEmJ8urh4gjBZ=J3wG0UesV_Ly8fQwg9nWfwKm2sU4FnA@mail.gmail.com>
 <dfc3e30e47a37f6386dc26d46814ae12@ispras.ru>
In-Reply-To: <dfc3e30e47a37f6386dc26d46814ae12@ispras.ru>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Thu, 9 Mar 2023 18:37:11 +0100
X-Gmail-Original-Message-ID: <CAMj1kXHeX8HiTo3G+87NOEttmOCoqws0KG+2bj13vZw_oB9Tfw@mail.gmail.com>
Message-ID: <CAMj1kXHeX8HiTo3G+87NOEttmOCoqws0KG+2bj13vZw_oB9Tfw@mail.gmail.com>
Subject: Re: [PATCH v4 19/26] x86/build: Cleanup tools/build.c
To:     Evgeniy Baskov <baskov@ispras.ru>
Cc:     Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Alexey Khoroshilov <khoroshilov@ispras.ru>,
        Peter Jones <pjones@redhat.com>,
        "Limonciello, Mario" <mario.limonciello@amd.com>,
        joeyli <jlee@suse.com>, lvc-project@linuxtesting.org,
        x86@kernel.org, linux-efi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, 9 Mar 2023 at 18:22, Evgeniy Baskov <baskov@ispras.ru> wrote:
>
> On 2023-03-09 19:50, Ard Biesheuvel wrote:
> > On Thu, 9 Mar 2023 at 17:25, Evgeniy Baskov <baskov@ispras.ru> wrote:
> >>
> >> On 2023-03-09 18:57, Ard Biesheuvel wrote:
> >> > On Thu, 15 Dec 2022 at 13:42, Evgeniy Baskov <baskov@ispras.ru> wrote:
> >> >>
> >> >> Use newer C standard. Since kernel requires C99 compiler now,
> >> >> we can make use of the new features to make the core more readable.
> >> >>
> >> >> Use mmap() for reading files also to make things simpler.
> >> >>
> >> >> Replace most magic numbers with defines.
> >> >>
> >> >> Should have no functional changes. This is done in preparation for the
> >> >> next changes that makes generated PE header more spec compliant.
> >> >>
> >> >> Tested-by: Mario Limonciello <mario.limonciello@amd.com>
> >> >> Tested-by: Peter Jones <pjones@redhat.com>
> >> >> Signed-off-by: Evgeniy Baskov <baskov@ispras.ru>
> >> >> ---
> >> >>  arch/x86/boot/tools/build.c | 387
> >> >> +++++++++++++++++++++++-------------
> >> >>  1 file changed, 245 insertions(+), 142 deletions(-)
> >> >>
> >> >> diff --git a/arch/x86/boot/tools/build.c b/arch/x86/boot/tools/build.c
> >> >> index bd247692b701..fbc5315af032 100644
> >> >> --- a/arch/x86/boot/tools/build.c
> >> >> +++ b/arch/x86/boot/tools/build.c
> >> >> @@ -25,20 +25,21 @@
> >> >>   * Substantially overhauled by H. Peter Anvin, April 2007
> >> >>   */
> >> >>
> >> >> +#include <fcntl.h>
> >> >> +#include <stdarg.h>
> >> >> +#include <stdint.h>
> >> >>  #include <stdio.h>
> >> >> -#include <string.h>
> >> >>  #include <stdlib.h>
> >> >> -#include <stdarg.h>
> >> >> -#include <sys/types.h>
> >> >> +#include <string.h>
> >> >> +#include <sys/mman.h>
> >> >>  #include <sys/stat.h>
> >> >> +#include <sys/types.h>
> >> >>  #include <unistd.h>
> >> >> -#include <fcntl.h>
> >> >> -#include <sys/mman.h>
> >> >> +
> >> >>  #include <tools/le_byteshift.h>
> >> >> +#include <linux/pe.h>
> >> >>
> >> >> -typedef unsigned char  u8;
> >> >> -typedef unsigned short u16;
> >> >> -typedef unsigned int   u32;
> >> >> +#define round_up(x, n) (((x) + (n) - 1) & ~((n) - 1))
> >> >>
> >> >>  #define DEFAULT_MAJOR_ROOT 0
> >> >>  #define DEFAULT_MINOR_ROOT 0
> >> >> @@ -48,8 +49,13 @@ typedef unsigned int   u32;
> >> >>  #define SETUP_SECT_MIN 5
> >> >>  #define SETUP_SECT_MAX 64
> >> >>
> >> >> +#define PARAGRAPH_SIZE 16
> >> >> +#define SECTOR_SIZE 512
> >> >> +#define FILE_ALIGNMENT 512
> >> >> +#define SECTION_ALIGNMENT 4096
> >> >> +
> >> >>  /* This must be large enough to hold the entire setup */
> >> >> -u8 buf[SETUP_SECT_MAX*512];
> >> >> +uint8_t buf[SETUP_SECT_MAX*SECTOR_SIZE];
> >> >>
> >> >>  #define PECOFF_RELOC_RESERVE 0x20
> >> >>
> >> >> @@ -59,6 +65,52 @@ u8 buf[SETUP_SECT_MAX*512];
> >> >>  #define PECOFF_COMPAT_RESERVE 0x0
> >> >>  #endif
> >> >>
> >> >> +#define RELOC_SECTION_SIZE 10
> >> >> +
> >> >> +/* PE header has different format depending on the architecture */
> >> >> +#ifdef CONFIG_X86_64
> >> >> +typedef struct pe32plus_opt_hdr pe_opt_hdr;
> >> >> +#else
> >> >> +typedef struct pe32_opt_hdr pe_opt_hdr;
> >> >> +#endif
> >> >> +
> >> >> +static inline struct pe_hdr *get_pe_header(uint8_t *buf)
> >> >> +{
> >> >> +       uint32_t pe_offset =
> >> >> get_unaligned_le32(buf+MZ_HEADER_PEADDR_OFFSET);
> >> >> +       return (struct pe_hdr *)(buf + pe_offset);
> >> >> +}
> >> >> +
> >> >> +static inline pe_opt_hdr *get_pe_opt_header(uint8_t *buf)
> >> >> +{
> >> >> +       return (pe_opt_hdr *)(get_pe_header(buf) + 1);
> >> >> +}
> >> >> +
> >> >> +static inline struct section_header *get_sections(uint8_t *buf)
> >> >> +{
> >> >> +       pe_opt_hdr *hdr = get_pe_opt_header(buf);
> >> >> +       uint32_t n_data_dirs = get_unaligned_le32(&hdr->data_dirs);
> >> >> +       uint8_t *sections = (uint8_t *)(hdr + 1) +
> >> >> n_data_dirs*sizeof(struct data_dirent);
> >> >> +       return  (struct section_header *)sections;
> >> >> +}
> >> >> +
> >> >> +static inline struct data_directory *get_data_dirs(uint8_t *buf)
> >> >> +{
> >> >> +       pe_opt_hdr *hdr = get_pe_opt_header(buf);
> >> >> +       return (struct data_directory *)(hdr + 1);
> >> >> +}
> >> >> +
> >> >> +#ifdef CONFIG_EFI_DXE_MEM_ATTRIBUTES
> >> >
> >> > Can we drop this conditional?
> >>
> >> Without CONFIG_EFI_DXE_MEM_ATTRIBUTES memory attributes are not
> >> getting applies anywhere, so this would break 'nokaslr' on UEFI
> >> implementations that honor section attributes.
> >>
> >
> > How so? This only affects the mappings that are created by UEFI for
> > the decompressor binary, right?
>
> I was thinking about the in-place decompression, but now I've realized
> that I was wrong since in-place decompression cannot happen when booting
> via the stub. I'll remove the ifdef.
>

Indeed. And I realized that all the image_offset handling can now be
dropped as well.

> >
> >> KASLR is already broken without that option on implementations
> >> that disallow execution of the free memory though. But unlike
> >> free memory, sections are more likely to get protected, I think.
> >>
> >
> > We need to allocate those pages properly in any case (see my other
> > reply) so it is no longer free memory.
>
> It should be fine, as I explained.
>
> The only thing that is a little unexpected is that the kernel might
> shift even with 'nokaslr' when the LOAD_PHYSICAL_ADDR is already taken
> by some firmware allocation (or by us). This should cause no real
> problems, since the kernel is required to be relocatable for the
> EFISTUB.
>

OK, good to know.

> >
> >> >> +#define SCN_RW (IMAGE_SCN_MEM_READ | IMAGE_SCN_MEM_WRITE |
> >> >> IMAGE_SCN_ALIGN_4096BYTES)
> >> >> +#define SCN_RX (IMAGE_SCN_MEM_READ | IMAGE_SCN_MEM_EXECUTE |
> >> >> IMAGE_SCN_ALIGN_4096BYTES)
> >> >> +#define SCN_RO (IMAGE_SCN_MEM_READ | IMAGE_SCN_ALIGN_4096BYTES)
> >> >
> >> > Please drop the alignment flags - they don't apply to executable only
> >> > object files.
> >>
> >> Got it, will remove them in v5.
> >>
> >> >
> >> >> +#else
> >> >> +/* With memory protection disabled all sections are RWX */
> >> >> +#define SCN_RW (IMAGE_SCN_MEM_READ | IMAGE_SCN_MEM_WRITE | \
> >> >> +               IMAGE_SCN_MEM_EXECUTE | IMAGE_SCN_ALIGN_4096BYTES)
> >> >> +#define SCN_RX SCN_RW
> >> >> +#define SCN_RO SCN_RW
> >> >> +#endif
> >> >> +
> >> >>  static unsigned long efi32_stub_entry;
> >> >>  static unsigned long efi64_stub_entry;
> >> >>  static unsigned long efi_pe_entry;
> >> >> @@ -70,7 +122,7 @@ static unsigned long _end;
> >> >>
> >> >>
> >> >> /*----------------------------------------------------------------------*/
> >> >>
> >> >> -static const u32 crctab32[] = {
> >> >> +static const uint32_t crctab32[] = {
> >> >
> >> > Replacing all the type names makes this patch very messy. Can we back
> >> > that out please?
> >>
> >> Ok, I will revert them.
> >>
> >> >
> >> >>         0x00000000, 0x77073096, 0xee0e612c, 0x990951ba, 0x076dc419,
> >> >>         0x706af48f, 0xe963a535, 0x9e6495a3, 0x0edb8832, 0x79dcb8a4,
> >> >>         0xe0d5e91e, 0x97d2d988, 0x09b64c2b, 0x7eb17cbd, 0xe7b82d07,
> >> >> @@ -125,12 +177,12 @@ static const u32 crctab32[] = {
> >> >>         0x2d02ef8d
> >> >>  };
> >> >>
> >> >> -static u32 partial_crc32_one(u8 c, u32 crc)
> >> >> +static uint32_t partial_crc32_one(uint8_t c, uint32_t crc)
> >> >>  {
> >> >>         return crctab32[(crc ^ c) & 0xff] ^ (crc >> 8);
> >> >>  }
> >> >>
> >> >> -static u32 partial_crc32(const u8 *s, int len, u32 crc)
> >> >> +static uint32_t partial_crc32(const uint8_t *s, int len, uint32_t
> >> >> crc)
> >> >>  {
> >> >>         while (len--)
> >> >>                 crc = partial_crc32_one(*s++, crc);
> >> >> @@ -152,57 +204,106 @@ static void usage(void)
> >> >>         die("Usage: build setup system zoffset.h image");
> >> >>  }
> >> >>
> >> >> +static void *map_file(const char *path, size_t *psize)
> >> >> +{
> >> >> +       struct stat statbuf;
> >> >> +       size_t size;
> >> >> +       void *addr;
> >> >> +       int fd;
> >> >> +
> >> >> +       fd = open(path, O_RDONLY);
> >> >> +       if (fd < 0)
> >> >> +               die("Unable to open `%s': %m", path);
> >> >> +       if (fstat(fd, &statbuf))
> >> >> +               die("Unable to stat `%s': %m", path);
> >> >> +
> >> >> +       size = statbuf.st_size;
> >> >> +       /*
> >> >> +        * Map one byte more, to allow adding null-terminator
> >> >> +        * for text files.
> >> >> +        */
> >> >> +       addr = mmap(NULL, size + 1, PROT_READ | PROT_WRITE,
> >> >> MAP_PRIVATE, fd, 0);
> >> >> +       if (addr == MAP_FAILED)
> >> >> +               die("Unable to mmap '%s': %m", path);
> >> >> +
> >> >> +       close(fd);
> >> >> +
> >> >> +       *psize = size;
> >> >> +       return addr;
> >> >> +}
> >> >> +
> >> >> +static void unmap_file(void *addr, size_t size)
> >> >> +{
> >> >> +       munmap(addr, size + 1);
> >> >> +}
> >> >> +
> >> >> +static void *map_output_file(const char *path, size_t size)
> >> >> +{
> >> >> +       void *addr;
> >> >> +       int fd;
> >> >> +
> >> >> +       fd = open(path, O_RDWR | O_CREAT, 0660);
> >> >> +       if (fd < 0)
> >> >> +               die("Unable to create `%s': %m", path);
> >> >> +
> >> >> +       if (ftruncate(fd, size))
> >> >> +               die("Unable to resize `%s': %m", path);
> >> >> +
> >> >> +       addr = mmap(NULL, size, PROT_READ | PROT_WRITE, MAP_SHARED,
> >> >> fd, 0);
> >> >> +       if (addr == MAP_FAILED)
> >> >> +               die("Unable to mmap '%s': %m", path);
> >> >> +
> >> >> +       return addr;
> >> >> +}
> >> >> +
> >> >>  #ifdef CONFIG_EFI_STUB
> >> >>
> >> >> -static void update_pecoff_section_header_fields(char *section_name,
> >> >> u32 vma, u32 size, u32 datasz, u32 offset)
> >> >> +static void update_pecoff_section_header_fields(char *section_name,
> >> >> uint32_t vma,
> >> >> +                                               uint32_t size,
> >> >> uint32_t datasz,
> >> >> +                                               uint32_t offset)
> >> >>  {
> >> >>         unsigned int pe_header;
> >> >>         unsigned short num_sections;
> >> >> -       u8 *section;
> >> >> +       struct section_header *section;
> >> >>
> >> >> -       pe_header = get_unaligned_le32(&buf[0x3c]);
> >> >> -       num_sections = get_unaligned_le16(&buf[pe_header + 6]);
> >> >> -
> >> >> -#ifdef CONFIG_X86_32
> >> >> -       section = &buf[pe_header + 0xa8];
> >> >> -#else
> >> >> -       section = &buf[pe_header + 0xb8];
> >> >> -#endif
> >> >> +       struct pe_hdr *hdr = get_pe_header(buf);
> >> >> +       num_sections = get_unaligned_le16(&hdr->sections);
> >> >> +       section = get_sections(buf);
> >> >>
> >> >>         while (num_sections > 0) {
> >> >> -               if (strncmp((char*)section, section_name, 8) == 0) {
> >> >> +               if (strncmp(section->name, section_name, 8) == 0) {
> >> >>                         /* section header size field */
> >> >> -                       put_unaligned_le32(size, section + 0x8);
> >> >> +                       put_unaligned_le32(size,
> >> >> &section->virtual_size);
> >> >>
> >> >>                         /* section header vma field */
> >> >> -                       put_unaligned_le32(vma, section + 0xc);
> >> >> +                       put_unaligned_le32(vma,
> >> >> &section->virtual_address);
> >> >>
> >> >>                         /* section header 'size of initialised data'
> >> >> field */
> >> >> -                       put_unaligned_le32(datasz, section + 0x10);
> >> >> +                       put_unaligned_le32(datasz,
> >> >> &section->raw_data_size);
> >> >>
> >> >>                         /* section header 'file offset' field */
> >> >> -                       put_unaligned_le32(offset, section + 0x14);
> >> >> +                       put_unaligned_le32(offset,
> >> >> &section->data_addr);
> >> >>
> >> >>                         break;
> >> >>                 }
> >> >> -               section += 0x28;
> >> >> +               section++;
> >> >>                 num_sections--;
> >> >>         }
> >> >>  }
> >> >>
> >> >> -static void update_pecoff_section_header(char *section_name, u32
> >> >> offset, u32 size)
> >> >> +static void update_pecoff_section_header(char *section_name, uint32_t
> >> >> offset, uint32_t size)
> >> >>  {
> >> >>         update_pecoff_section_header_fields(section_name, offset,
> >> >> size, size, offset);
> >> >>  }
> >> >>
> >> >>  static void update_pecoff_setup_and_reloc(unsigned int size)
> >> >>  {
> >> >> -       u32 setup_offset = 0x200;
> >> >> -       u32 reloc_offset = size - PECOFF_RELOC_RESERVE -
> >> >> PECOFF_COMPAT_RESERVE;
> >> >> +       uint32_t setup_offset = SECTOR_SIZE;
> >> >> +       uint32_t reloc_offset = size - PECOFF_RELOC_RESERVE -
> >> >> PECOFF_COMPAT_RESERVE;
> >> >>  #ifdef CONFIG_EFI_MIXED
> >> >> -       u32 compat_offset = reloc_offset + PECOFF_RELOC_RESERVE;
> >> >> +       uint32_t compat_offset = reloc_offset + PECOFF_RELOC_RESERVE;
> >> >>  #endif
> >> >> -       u32 setup_size = reloc_offset - setup_offset;
> >> >> +       uint32_t setup_size = reloc_offset - setup_offset;
> >> >>
> >> >>         update_pecoff_section_header(".setup", setup_offset,
> >> >> setup_size);
> >> >>         update_pecoff_section_header(".reloc", reloc_offset,
> >> >> PECOFF_RELOC_RESERVE);
> >> >> @@ -211,8 +312,8 @@ static void update_pecoff_setup_and_reloc(unsigned
> >> >> int size)
> >> >>          * Modify .reloc section contents with a single entry. The
> >> >>          * relocation is applied to offset 10 of the relocation
> >> >> section.
> >> >>          */
> >> >> -       put_unaligned_le32(reloc_offset + 10, &buf[reloc_offset]);
> >> >> -       put_unaligned_le32(10, &buf[reloc_offset + 4]);
> >> >> +       put_unaligned_le32(reloc_offset + RELOC_SECTION_SIZE,
> >> >> &buf[reloc_offset]);
> >> >> +       put_unaligned_le32(RELOC_SECTION_SIZE, &buf[reloc_offset +
> >> >> 4]);
> >> >>
> >> >>  #ifdef CONFIG_EFI_MIXED
> >> >>         update_pecoff_section_header(".compat", compat_offset,
> >> >> PECOFF_COMPAT_RESERVE);
> >> >> @@ -224,19 +325,17 @@ static void
> >> >> update_pecoff_setup_and_reloc(unsigned int size)
> >> >>          */
> >> >>         buf[compat_offset] = 0x1;
> >> >>         buf[compat_offset + 1] = 0x8;
> >> >> -       put_unaligned_le16(0x14c, &buf[compat_offset + 2]);
> >> >> +       put_unaligned_le16(IMAGE_FILE_MACHINE_I386, &buf[compat_offset
> >> >> + 2]);
> >> >>         put_unaligned_le32(efi32_pe_entry + size, &buf[compat_offset +
> >> >> 4]);
> >> >>  #endif
> >> >>  }
> >> >>
> >> >> -static void update_pecoff_text(unsigned int text_start, unsigned int
> >> >> file_sz,
> >> >> +static unsigned int update_pecoff_sections(unsigned int text_start,
> >> >> unsigned int text_sz,
> >> >>                                unsigned int init_sz)
> >> >>  {
> >> >> -       unsigned int pe_header;
> >> >> -       unsigned int text_sz = file_sz - text_start;
> >> >> +       unsigned int file_sz = text_start + text_sz;
> >> >>         unsigned int bss_sz = init_sz - file_sz;
> >> >> -
> >> >> -       pe_header = get_unaligned_le32(&buf[0x3c]);
> >> >> +       pe_opt_hdr *hdr = get_pe_opt_header(buf);
> >> >>
> >> >>         /*
> >> >>          * The PE/COFF loader may load the image at an address which
> >> >> is
> >> >> @@ -254,18 +353,20 @@ static void update_pecoff_text(unsigned int
> >> >> text_start, unsigned int file_sz,
> >> >>          * Size of code: Subtract the size of the first sector (512
> >> >> bytes)
> >> >>          * which includes the header.
> >> >>          */
> >> >> -       put_unaligned_le32(file_sz - 512 + bss_sz, &buf[pe_header +
> >> >> 0x1c]);
> >> >> +       put_unaligned_le32(file_sz - SECTOR_SIZE + bss_sz,
> >> >> &hdr->text_size);
> >> >>
> >> >>         /* Size of image */
> >> >> -       put_unaligned_le32(init_sz, &buf[pe_header + 0x50]);
> >> >> +       put_unaligned_le32(init_sz, &hdr->image_size);
> >> >>
> >> >>         /*
> >> >>          * Address of entry point for PE/COFF executable
> >> >>          */
> >> >> -       put_unaligned_le32(text_start + efi_pe_entry, &buf[pe_header +
> >> >> 0x28]);
> >> >> +       put_unaligned_le32(text_start + efi_pe_entry,
> >> >> &hdr->entry_point);
> >> >>
> >> >>         update_pecoff_section_header_fields(".text", text_start,
> >> >> text_sz + bss_sz,
> >> >>                                             text_sz, text_start);
> >> >> +
> >> >> +       return text_start + file_sz;
> >> >>  }
> >> >>
> >> >>  static int reserve_pecoff_reloc_section(int c)
> >> >> @@ -275,7 +376,7 @@ static int reserve_pecoff_reloc_section(int c)
> >> >>         return PECOFF_RELOC_RESERVE;
> >> >>  }
> >> >>
> >> >> -static void efi_stub_defaults(void)
> >> >> +static void efi_stub_update_defaults(void)
> >> >>  {
> >> >>         /* Defaults for old kernel */
> >> >>  #ifdef CONFIG_X86_32
> >> >> @@ -298,7 +399,7 @@ static void efi_stub_entry_update(void)
> >> >>
> >> >>  #ifdef CONFIG_EFI_MIXED
> >> >>         if (efi32_stub_entry != addr)
> >> >> -               die("32-bit and 64-bit EFI entry points do not
> >> >> match\n");
> >> >> +               die("32-bit and 64-bit EFI entry points do not
> >> >> match");
> >> >>  #endif
> >> >>  #endif
> >> >>         put_unaligned_le32(addr, &buf[0x264]);
> >> >> @@ -310,7 +411,7 @@ static inline void
> >> >> update_pecoff_setup_and_reloc(unsigned int size) {}
> >> >>  static inline void update_pecoff_text(unsigned int text_start,
> >> >>                                       unsigned int file_sz,
> >> >>                                       unsigned int init_sz) {}
> >> >> -static inline void efi_stub_defaults(void) {}
> >> >> +static inline void efi_stub_update_defaults(void) {}
> >> >>  static inline void efi_stub_entry_update(void) {}
> >> >>
> >> >>  static inline int reserve_pecoff_reloc_section(int c)
> >> >> @@ -338,20 +439,15 @@ static int reserve_pecoff_compat_section(int c)
> >> >>
> >> >>  static void parse_zoffset(char *fname)
> >> >>  {
> >> >> -       FILE *file;
> >> >> -       char *p;
> >> >> -       int c;
> >> >> +       size_t size;
> >> >> +       char *data, *p;
> >> >>
> >> >> -       file = fopen(fname, "r");
> >> >> -       if (!file)
> >> >> -               die("Unable to open `%s': %m", fname);
> >> >> -       c = fread(buf, 1, sizeof(buf) - 1, file);
> >> >> -       if (ferror(file))
> >> >> -               die("read-error on `zoffset.h'");
> >> >> -       fclose(file);
> >> >> -       buf[c] = 0;
> >> >> +       data = map_file(fname, &size);
> >> >>
> >> >> -       p = (char *)buf;
> >> >> +       /* We can do that, since we mapped one byte more */
> >> >> +       data[size] = 0;
> >> >> +
> >> >> +       p = (char *)data;
> >> >>
> >> >>         while (p && *p) {
> >> >>                 PARSE_ZOFS(p, efi32_stub_entry);
> >> >> @@ -367,82 +463,99 @@ static void parse_zoffset(char *fname)
> >> >>                 while (p && (*p == '\r' || *p == '\n'))
> >> >>                         p++;
> >> >>         }
> >> >> +
> >> >> +       unmap_file(data, size);
> >> >>  }
> >> >>
> >> >> -int main(int argc, char ** argv)
> >> >> +static unsigned int read_setup(char *path)
> >> >>  {
> >> >> -       unsigned int i, sz, setup_sectors, init_sz;
> >> >> -       int c;
> >> >> -       u32 sys_size;
> >> >> -       struct stat sb;
> >> >> -       FILE *file, *dest;
> >> >> -       int fd;
> >> >> -       void *kernel;
> >> >> -       u32 crc = 0xffffffffUL;
> >> >> -
> >> >> -       efi_stub_defaults();
> >> >> -
> >> >> -       if (argc != 5)
> >> >> -               usage();
> >> >> -       parse_zoffset(argv[3]);
> >> >> -
> >> >> -       dest = fopen(argv[4], "w");
> >> >> -       if (!dest)
> >> >> -               die("Unable to write `%s': %m", argv[4]);
> >> >> +       FILE *file;
> >> >> +       unsigned int setup_size, file_size;
> >> >>
> >> >>         /* Copy the setup code */
> >> >> -       file = fopen(argv[1], "r");
> >> >> +       file = fopen(path, "r");
> >> >>         if (!file)
> >> >> -               die("Unable to open `%s': %m", argv[1]);
> >> >> -       c = fread(buf, 1, sizeof(buf), file);
> >> >> +               die("Unable to open `%s': %m", path);
> >> >> +
> >> >> +       file_size = fread(buf, 1, sizeof(buf), file);
> >> >>         if (ferror(file))
> >> >>                 die("read-error on `setup'");
> >> >> -       if (c < 1024)
> >> >> +
> >> >> +       if (file_size < 2 * SECTOR_SIZE)
> >> >>                 die("The setup must be at least 1024 bytes");
> >> >> -       if (get_unaligned_le16(&buf[510]) != 0xAA55)
> >> >> +
> >> >> +       if (get_unaligned_le16(&buf[SECTOR_SIZE - 2]) != 0xAA55)
> >> >>                 die("Boot block hasn't got boot flag (0xAA55)");
> >> >> +
> >> >>         fclose(file);
> >> >>
> >> >> -       c += reserve_pecoff_compat_section(c);
> >> >> -       c += reserve_pecoff_reloc_section(c);
> >> >> +       /* Reserve space for PE sections */
> >> >> +       file_size += reserve_pecoff_compat_section(file_size);
> >> >> +       file_size += reserve_pecoff_reloc_section(file_size);
> >> >>
> >> >>         /* Pad unused space with zeros */
> >> >> -       setup_sectors = (c + 511) / 512;
> >> >> -       if (setup_sectors < SETUP_SECT_MIN)
> >> >> -               setup_sectors = SETUP_SECT_MIN;
> >> >> -       i = setup_sectors*512;
> >> >> -       memset(buf+c, 0, i-c);
> >> >>
> >> >> -       update_pecoff_setup_and_reloc(i);
> >> >> +       setup_size = round_up(file_size, SECTOR_SIZE);
> >> >> +
> >> >> +       if (setup_size < SETUP_SECT_MIN * SECTOR_SIZE)
> >> >> +               setup_size = SETUP_SECT_MIN * SECTOR_SIZE;
> >> >> +
> >> >> +       /*
> >> >> +        * Global buffer is already initialised
> >> >> +        * to 0, but just in case, zero out padding.
> >> >> +        */
> >> >> +
> >> >> +       memset(buf + file_size, 0, setup_size - file_size);
> >> >> +
> >> >> +       return setup_size;
> >> >> +}
> >> >> +
> >> >> +int main(int argc, char **argv)
> >> >> +{
> >> >> +       size_t kern_file_size;
> >> >> +       unsigned int setup_size;
> >> >> +       unsigned int setup_sectors;
> >> >> +       unsigned int init_size;
> >> >> +       unsigned int total_size;
> >> >> +       unsigned int kern_size;
> >> >> +       void *kernel;
> >> >> +       uint32_t crc = 0xffffffffUL;
> >> >> +       uint8_t *output;
> >> >> +
> >> >> +       if (argc != 5)
> >> >> +               usage();
> >> >> +
> >> >> +       efi_stub_update_defaults();
> >> >> +       parse_zoffset(argv[3]);
> >> >> +
> >> >> +       setup_size = read_setup(argv[1]);
> >> >> +
> >> >> +       setup_sectors = setup_size/SECTOR_SIZE;
> >> >>
> >> >>         /* Set the default root device */
> >> >>         put_unaligned_le16(DEFAULT_ROOT_DEV, &buf[508]);
> >> >>
> >> >> -       /* Open and stat the kernel file */
> >> >> -       fd = open(argv[2], O_RDONLY);
> >> >> -       if (fd < 0)
> >> >> -               die("Unable to open `%s': %m", argv[2]);
> >> >> -       if (fstat(fd, &sb))
> >> >> -               die("Unable to stat `%s': %m", argv[2]);
> >> >> -       sz = sb.st_size;
> >> >> -       kernel = mmap(NULL, sz, PROT_READ, MAP_SHARED, fd, 0);
> >> >> -       if (kernel == MAP_FAILED)
> >> >> -               die("Unable to mmap '%s': %m", argv[2]);
> >> >> -       /* Number of 16-byte paragraphs, including space for a 4-byte
> >> >> CRC */
> >> >> -       sys_size = (sz + 15 + 4) / 16;
> >> >> +       /* Map kernel file to memory */
> >> >> +       kernel = map_file(argv[2], &kern_file_size);
> >> >> +
> >> >>  #ifdef CONFIG_EFI_STUB
> >> >> -       /*
> >> >> -        * COFF requires minimum 32-byte alignment of sections, and
> >> >> -        * adding a signature is problematic without that alignment.
> >> >> -        */
> >> >> -       sys_size = (sys_size + 1) & ~1;
> >> >> +       /* PE specification require 512-byte minimum section file
> >> >> alignment */
> >> >> +       kern_size = round_up(kern_file_size + 4, SECTOR_SIZE);
> >> >> +       update_pecoff_setup_and_reloc(setup_size);
> >> >> +#else
> >> >> +       /* Number of 16-byte paragraphs, including space for a 4-byte
> >> >> CRC */
> >> >> +       kern_size = round_up(kern_file_size + 4, PARAGRAPH_SIZE);
> >> >>  #endif
> >> >>
> >> >>         /* Patch the setup code with the appropriate size parameters
> >> >> */
> >> >> -       buf[0x1f1] = setup_sectors-1;
> >> >> -       put_unaligned_le32(sys_size, &buf[0x1f4]);
> >> >> +       buf[0x1f1] = setup_sectors - 1;
> >> >> +       put_unaligned_le32(kern_size/PARAGRAPH_SIZE, &buf[0x1f4]);
> >> >> +
> >> >> +       /* Update kernel_info offset. */
> >> >> +       put_unaligned_le32(kernel_info, &buf[0x268]);
> >> >> +
> >> >> +       init_size = get_unaligned_le32(&buf[0x260]);
> >> >>
> >> >> -       init_sz = get_unaligned_le32(&buf[0x260]);
> >> >>  #ifdef CONFIG_EFI_STUB
> >> >>         /*
> >> >>          * The decompression buffer will start at ImageBase. When
> >> >> relocating
> >> >> @@ -458,45 +571,35 @@ int main(int argc, char ** argv)
> >> >>          * For future-proofing, increase init_sz if necessary.
> >> >>          */
> >> >>
> >> >> -       if (init_sz - _end < i + _ehead) {
> >> >> -               init_sz = (i + _ehead + _end + 4095) & ~4095;
> >> >> -               put_unaligned_le32(init_sz, &buf[0x260]);
> >> >> +       if (init_size - _end < setup_size + _ehead) {
> >> >> +               init_size = round_up(setup_size + _ehead + _end,
> >> >> SECTION_ALIGNMENT);
> >> >> +               put_unaligned_le32(init_size, &buf[0x260]);
> >> >>         }
> >> >> -#endif
> >> >> -       update_pecoff_text(setup_sectors * 512, i + (sys_size * 16),
> >> >> init_sz);
> >> >>
> >> >> -       efi_stub_entry_update();
> >> >> -
> >> >> -       /* Update kernel_info offset. */
> >> >> -       put_unaligned_le32(kernel_info, &buf[0x268]);
> >> >> +       total_size = update_pecoff_sections(setup_size, kern_size,
> >> >> init_size);
> >> >>
> >> >> -       crc = partial_crc32(buf, i, crc);
> >> >> -       if (fwrite(buf, 1, i, dest) != i)
> >> >> -               die("Writing setup failed");
> >> >> +       efi_stub_entry_update();
> >> >> +#else
> >> >> +       (void)init_size;
> >> >> +       total_size = setup_size + kern_size;
> >> >> +#endif
> >> >>
> >> >> -       /* Copy the kernel code */
> >> >> -       crc = partial_crc32(kernel, sz, crc);
> >> >> -       if (fwrite(kernel, 1, sz, dest) != sz)
> >> >> -               die("Writing kernel failed");
> >> >> +       output = map_output_file(argv[4], total_size);
> >> >>
> >> >> -       /* Add padding leaving 4 bytes for the checksum */
> >> >> -       while (sz++ < (sys_size*16) - 4) {
> >> >> -               crc = partial_crc32_one('\0', crc);
> >> >> -               if (fwrite("\0", 1, 1, dest) != 1)
> >> >> -                       die("Writing padding failed");
> >> >> -       }
> >> >> +       memcpy(output, buf, setup_size);
> >> >> +       memcpy(output + setup_size, kernel, kern_file_size);
> >> >> +       memset(output + setup_size + kern_file_size, 0, kern_size -
> >> >> kern_file_size);
> >> >>
> >> >> -       /* Write the CRC */
> >> >> -       put_unaligned_le32(crc, buf);
> >> >> -       if (fwrite(buf, 1, 4, dest) != 4)
> >> >> -               die("Writing CRC failed");
> >> >> +       /* Calculate and write kernel checksum. */
> >> >> +       crc = partial_crc32(output, total_size - 4, crc);
> >> >> +       put_unaligned_le32(crc, &output[total_size - 4]);
> >> >>
> >> >> -       /* Catch any delayed write failures */
> >> >> -       if (fclose(dest))
> >> >> -               die("Writing image failed");
> >> >> +       /* Catch any delayed write failures. */
> >> >> +       if (munmap(output, total_size) < 0)
> >> >> +               die("Writing kernel failed");
> >> >>
> >> >> -       close(fd);
> >> >> +       unmap_file(kernel, kern_file_size);
> >> >>
> >> >> -       /* Everything is OK */
> >> >> +       /* Everything is OK. */
> >> >>         return 0;
> >> >>  }
> >> >> --
> >> >> 2.37.4
> >> >>
